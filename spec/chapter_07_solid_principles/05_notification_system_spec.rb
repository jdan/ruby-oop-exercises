# frozen_string_literal: true

require 'chapter_07_solid_principles/05_notification_system'

RSpec.describe MessageSender do
  it 'defines send_message that raises NotImplementedError' do
    klass = Class.new { include MessageSender }
    expect { klass.new.send_message('user', 'hello') }.to raise_error(NotImplementedError)
  end
end

RSpec.describe EmailSender do
  describe 'module inclusion' do
    it 'includes MessageSender' do
      expect(EmailSender.included_modules).to include(MessageSender)
    end
  end

  describe '#initialize' do
    it 'accepts an optional smtp_server' do
      sender = EmailSender.new(smtp_server: 'mail.example.com')
      expect(sender.smtp_server).to eq('mail.example.com')
    end

    it 'has a default smtp_server' do
      sender = EmailSender.new
      expect(sender.smtp_server).to eq('smtp.default.com')
    end
  end

  describe '#send_message' do
    it 'returns confirmation with server info' do
      sender = EmailSender.new(smtp_server: 'mail.example.com')
      result = sender.send_message('user@example.com', 'Hello!')

      expect(result).to eq('Email sent to user@example.com via mail.example.com: Hello!')
    end
  end
end

RSpec.describe SmsSender do
  describe 'module inclusion' do
    it 'includes MessageSender' do
      expect(SmsSender.included_modules).to include(MessageSender)
    end
  end

  describe '#initialize' do
    it 'accepts an optional api_key' do
      sender = SmsSender.new(api_key: 'secret123')
      expect(sender.api_key).to eq('secret123')
    end

    it 'has a default api_key' do
      sender = SmsSender.new
      expect(sender.api_key).to eq('default_key')
    end
  end

  describe '#send_message' do
    it 'returns confirmation' do
      sender = SmsSender.new
      result = sender.send_message('+1234567890', 'Hello!')

      expect(result).to eq('SMS sent to +1234567890: Hello!')
    end
  end
end

RSpec.describe PushSender do
  describe 'module inclusion' do
    it 'includes MessageSender' do
      expect(PushSender.included_modules).to include(MessageSender)
    end
  end

  describe '#initialize' do
    it 'accepts an optional app_id' do
      sender = PushSender.new(app_id: 'my_app')
      expect(sender.app_id).to eq('my_app')
    end

    it 'has a default app_id' do
      sender = PushSender.new
      expect(sender.app_id).to eq('default_app')
    end
  end

  describe '#send_message' do
    it 'returns confirmation with app info' do
      sender = PushSender.new(app_id: 'my_app')
      result = sender.send_message('device_token', 'Hello!')

      expect(result).to eq('Push sent to device_token from my_app: Hello!')
    end
  end
end

RSpec.describe MockSender do
  describe 'module inclusion' do
    it 'includes MessageSender' do
      expect(MockSender.included_modules).to include(MessageSender)
    end
  end

  describe '#initialize' do
    it 'starts with an empty messages array' do
      sender = MockSender.new
      expect(sender.messages).to eq([])
    end
  end

  describe '#send_message' do
    it 'stores the message and returns mock confirmation' do
      sender = MockSender.new
      result = sender.send_message('user', 'Hello!')

      expect(result).to eq('Mock: user')
      expect(sender.messages).to eq([{ recipient: 'user', message: 'Hello!' }])
    end

    it 'accumulates multiple messages' do
      sender = MockSender.new
      sender.send_message('user1', 'Hi')
      sender.send_message('user2', 'Hello')

      expect(sender.messages.length).to eq(2)
    end
  end
end

RSpec.describe NotificationService do
  describe '#initialize' do
    it 'receives a sender via dependency injection' do
      sender = EmailSender.new
      service = NotificationService.new(sender)

      expect(service.sender).to eq(sender)
    end
  end

  describe '#notify' do
    it 'delegates to the sender' do
      sender = MockSender.new
      service = NotificationService.new(sender)

      result = service.notify('user', 'Test message')

      expect(result).to eq('Mock: user')
      expect(sender.messages.first[:message]).to eq('Test message')
    end

    it 'works with any sender implementation' do
      email_sender = EmailSender.new
      service = NotificationService.new(email_sender)

      result = service.notify('user@test.com', 'Hello')

      expect(result).to include('Email sent to user@test.com')
    end
  end

  describe '#notify_all' do
    it 'sends to multiple recipients' do
      sender = MockSender.new
      service = NotificationService.new(sender)

      results = service.notify_all(%w[user1 user2 user3], 'Broadcast')

      expect(results.length).to eq(3)
      expect(sender.messages.length).to eq(3)
    end
  end

  describe '#change_sender' do
    it 'allows swapping the sender at runtime' do
      email_sender = EmailSender.new
      sms_sender = SmsSender.new
      service = NotificationService.new(email_sender)

      service.change_sender(sms_sender)

      expect(service.sender).to eq(sms_sender)
    end
  end
end

RSpec.describe UserAlertSystem do
  describe '#initialize' do
    it 'receives a NotificationService via dependency injection' do
      sender = MockSender.new
      service = NotificationService.new(sender)
      alert_system = UserAlertSystem.new(service)

      expect(alert_system).to be_a(UserAlertSystem)
    end
  end

  describe '#send_alert' do
    it 'formats and sends an alert' do
      sender = MockSender.new
      service = NotificationService.new(sender)
      alert_system = UserAlertSystem.new(service)

      alert_system.send_alert('alice', 'warning', 'Disk space low')

      expect(sender.messages.first[:recipient]).to eq('alice')
      expect(sender.messages.first[:message]).to include('warning')
      expect(sender.messages.first[:message]).to include('Disk space low')
    end
  end

  describe '#send_welcome' do
    it 'sends a welcome message' do
      sender = MockSender.new
      service = NotificationService.new(sender)
      alert_system = UserAlertSystem.new(service)

      alert_system.send_welcome('bob')

      expect(sender.messages.first[:recipient]).to eq('bob')
      expect(sender.messages.first[:message]).to match(/welcome/i)
    end
  end

  describe '#send_password_reset' do
    it 'sends a password reset message' do
      sender = MockSender.new
      service = NotificationService.new(sender)
      alert_system = UserAlertSystem.new(service)

      alert_system.send_password_reset('carol')

      expect(sender.messages.first[:recipient]).to eq('carol')
      expect(sender.messages.first[:message]).to match(/password/i)
    end
  end

  describe 'Dependency Inversion Principle' do
    it 'works with any sender without modification' do
      # Using different senders demonstrates DIP
      email_service = NotificationService.new(EmailSender.new)
      sms_service = NotificationService.new(SmsSender.new)
      push_service = NotificationService.new(PushSender.new)

      email_alert = UserAlertSystem.new(email_service)
      sms_alert = UserAlertSystem.new(sms_service)
      push_alert = UserAlertSystem.new(push_service)

      # All work the same way
      expect(email_alert.send_welcome('user')).to include('Email sent')
      expect(sms_alert.send_welcome('user')).to include('SMS sent')
      expect(push_alert.send_welcome('user')).to include('Push sent')
    end
  end
end
