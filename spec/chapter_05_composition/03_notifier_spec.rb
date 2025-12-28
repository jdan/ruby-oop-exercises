# frozen_string_literal: true

require 'chapter_05_composition/03_notifier'

RSpec.describe EmailSender do
  describe '#send_message' do
    it 'returns a formatted email message' do
      sender = EmailSender.new
      result = sender.send_message('user@example.com', 'Hello!')

      expect(result).to eq('Email to user@example.com: Hello!')
    end
  end
end

RSpec.describe SmsSender do
  describe '#send_message' do
    it 'returns a formatted SMS message' do
      sender = SmsSender.new
      result = sender.send_message('555-1234', 'Hello!')

      expect(result).to eq('SMS to 555-1234: Hello!')
    end
  end
end

RSpec.describe PushNotificationSender do
  describe '#send_message' do
    it 'returns a formatted push notification' do
      sender = PushNotificationSender.new
      result = sender.send_message('device_token_123', 'Hello!')

      expect(result).to eq('Push to device_token_123: Hello!')
    end
  end
end

RSpec.describe NotificationService do
  describe '#initialize' do
    it 'creates a service with multiple senders' do
      email = EmailSender.new
      sms = SmsSender.new
      service = NotificationService.new([email, sms])

      expect(service.senders).to contain_exactly(email, sms)
    end
  end

  describe '#notify' do
    it 'sends message through all registered senders' do
      email = EmailSender.new
      sms = SmsSender.new
      service = NotificationService.new([email, sms])

      results = service.notify('recipient', 'Important update!')

      expect(results).to contain_exactly(
        'Email to recipient: Important update!',
        'SMS to recipient: Important update!'
      )
    end

    it 'works with a single sender' do
      push = PushNotificationSender.new
      service = NotificationService.new([push])

      results = service.notify('device_abc', 'New message')

      expect(results).to eq(['Push to device_abc: New message'])
    end

    it 'returns empty array when no senders configured' do
      service = NotificationService.new([])

      results = service.notify('anyone', 'Hello')

      expect(results).to eq([])
    end
  end

  describe '#add_sender' do
    it 'adds a new sender to the service' do
      email = EmailSender.new
      service = NotificationService.new([email])

      sms = SmsSender.new
      service.add_sender(sms)

      expect(service.senders).to contain_exactly(email, sms)
    end
  end

  describe '#remove_sender' do
    it 'removes a sender from the service' do
      email = EmailSender.new
      sms = SmsSender.new
      service = NotificationService.new([email, sms])

      service.remove_sender(email)

      expect(service.senders).to contain_exactly(sms)
    end
  end
end
