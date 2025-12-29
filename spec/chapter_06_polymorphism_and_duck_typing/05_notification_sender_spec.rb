# frozen_string_literal: true

require 'chapter_06_polymorphism_and_duck_typing/05_notification_sender'

RSpec.describe Chapter06::EmailChannel do
  describe '#deliver' do
    it 'returns formatted email notification' do
      channel = described_class.new

      result = channel.deliver('user@test.com', 'Welcome!', 'Thanks for signing up')

      expect(result).to eq('EMAIL to user@test.com | Subject: Welcome! | Body: Thanks for signing up')
    end
  end

  describe '#channel_name' do
    it 'returns email' do
      expect(described_class.new.channel_name).to eq('email')
    end
  end

  describe '#supports_html?' do
    it 'returns true' do
      expect(described_class.new.supports_html?).to be true
    end
  end
end

RSpec.describe Chapter06::SmsChannel do
  describe '#deliver' do
    it 'returns formatted SMS notification' do
      channel = described_class.new

      result = channel.deliver('555-1234', 'Alert', 'Your code is 1234')

      expect(result).to eq('SMS to 555-1234 | Your code is 1234')
    end

    it 'ignores subject for SMS' do
      channel = described_class.new

      result = channel.deliver('555-0000', 'Important Subject', 'Message body')

      expect(result).not_to include('Important Subject')
      expect(result).to include('Message body')
    end
  end

  describe '#channel_name' do
    it 'returns sms' do
      expect(described_class.new.channel_name).to eq('sms')
    end
  end

  describe '#supports_html?' do
    it 'returns false' do
      expect(described_class.new.supports_html?).to be false
    end
  end
end

RSpec.describe Chapter06::SlackChannel do
  describe '#deliver' do
    it 'returns formatted Slack notification' do
      channel = described_class.new

      result = channel.deliver('#general', 'Announcement', 'Team meeting at 3pm')

      expect(result).to eq('SLACK to #general | *Announcement* | Team meeting at 3pm')
    end
  end

  describe '#channel_name' do
    it 'returns slack' do
      expect(described_class.new.channel_name).to eq('slack')
    end
  end

  describe '#supports_html?' do
    it 'returns false (uses markdown instead)' do
      expect(described_class.new.supports_html?).to be false
    end
  end
end

RSpec.describe Chapter06::PushChannel do
  describe '#deliver' do
    it 'returns formatted push notification' do
      channel = described_class.new

      result = channel.deliver('device_token_xyz', 'New Message', 'You have 3 new messages')

      expect(result).to eq('PUSH to device_token_xyz | Title: New Message | You have 3 new messages')
    end
  end

  describe '#channel_name' do
    it 'returns push' do
      expect(described_class.new.channel_name).to eq('push')
    end
  end

  describe '#supports_html?' do
    it 'returns false' do
      expect(described_class.new.supports_html?).to be false
    end
  end
end

RSpec.describe Chapter06::NotificationDispatcher do
  describe '#initialize' do
    it 'creates dispatcher with multiple channels' do
      email = Chapter06::EmailChannel.new
      sms = Chapter06::SmsChannel.new
      dispatcher = described_class.new([email, sms])

      expect(dispatcher.channels).to contain_exactly(email, sms)
    end
  end

  describe '#send_to_all' do
    it 'sends notification through all channels' do
      email = Chapter06::EmailChannel.new
      slack = Chapter06::SlackChannel.new
      dispatcher = described_class.new([email, slack])

      results = dispatcher.send_to_all('recipient', 'Hello', 'Test message')

      expect(results.size).to eq(2)
      expect(results[0]).to include('EMAIL')
      expect(results[1]).to include('SLACK')
    end
  end

  describe '#send_via' do
    it 'sends through specific channel by name' do
      email = Chapter06::EmailChannel.new
      sms = Chapter06::SmsChannel.new
      dispatcher = described_class.new([email, sms])

      result = dispatcher.send_via('sms', '555-1234', 'Alert', 'Code: 9999')

      expect(result).to eq('SMS to 555-1234 | Code: 9999')
    end

    it 'returns nil if channel not found' do
      email = Chapter06::EmailChannel.new
      dispatcher = described_class.new([email])

      result = dispatcher.send_via('slack', '#channel', 'Test', 'Message')

      expect(result).to be_nil
    end
  end

  describe '#html_capable_channels' do
    it 'returns only channels that support HTML' do
      email = Chapter06::EmailChannel.new
      sms = Chapter06::SmsChannel.new
      slack = Chapter06::SlackChannel.new
      dispatcher = described_class.new([email, sms, slack])

      result = dispatcher.html_capable_channels

      expect(result).to contain_exactly(email)
    end
  end

  describe '#available_channels' do
    it 'returns list of channel names' do
      email = Chapter06::EmailChannel.new
      sms = Chapter06::SmsChannel.new
      push = Chapter06::PushChannel.new
      dispatcher = described_class.new([email, sms, push])

      result = dispatcher.available_channels

      expect(result).to eq(%w[email sms push])
    end
  end
end
