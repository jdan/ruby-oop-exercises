# frozen_string_literal: true

# Dependency Inversion Principle (DIP)
#
# High-level modules should not depend on low-level modules.
# Both should depend on abstractions.
#
# NotificationService depends on the MessageSender abstraction,
# not on concrete EmailSender, SmsSender, etc. implementations.
# Dependencies are injected, not instantiated internally.

module Chapter07
  # MessageSender module (abstraction):
  # - send_message(recipient, message) - raises NotImplementedError

  ##
  # Abstract interface for sending messages
  module MessageSender
    def send_message(_recipient, _message)
      raise NotImplementedError
    end
  end

  # EmailSender class:
  # - includes MessageSender
  # - initialize(smtp_server: "smtp.default.com")
  # - smtp_server reader
  # - send_message(recipient, message) - returns "Email sent to X via Y: Z"

  ##
  # Concrete implementation for email
  class EmailSender
    include MessageSender

    attr_reader :smtp_server

    def initialize(smtp_server: 'smtp.default.com')
      @smtp_server = smtp_server
    end

    def send_message(recipient, message)
      "Email sent to #{recipient} via #{smtp_server}: #{message}"
    end
  end

  # SmsSender class:
  # - includes MessageSender
  # - initialize(api_key: "default_key")
  # - api_key reader
  # - send_message(recipient, message) - returns "SMS sent to X: Y"

  ##
  # Concrete implementation for SMS
  class SmsSender
    include MessageSender

    attr_reader :api_key

    def initialize(api_key: 'default_key')
      @api_key = api_key
    end

    def send_message(recipient, message)
      "SMS sent to #{recipient}: #{message}"
    end
  end

  # PushSender class:
  # - includes MessageSender
  # - initialize(app_id: "default_app")
  # - app_id reader
  # - send_message(recipient, message) - returns "Push sent to X from Y: Z"

  ##
  # Concrete implementation for push notifications
  class PushSender
    include MessageSender

    attr_reader :app_id

    def initialize(app_id: 'default_app')
      @app_id = app_id
    end

    def send_message(recipient, message)
      "Push sent to #{recipient} from #{app_id}: #{message}"
    end
  end

  # MockSender class:
  # - includes MessageSender
  # - initialize (creates empty messages array)
  # - messages reader (returns array of {recipient:, message:} hashes)
  # - send_message(recipient, message) - stores and returns "Mock: X"

  ##
  # Test double for unit testing (demonstrates easy testing with DIP)
  class MockSender
    include MessageSender

    attr_reader :messages

    def initialize
      @messages = []
    end

    def send_message(recipient, message)
      sent = "Mock: #{message}"
      @messages << { recipient:, message: }
      sent
    end
  end

  # NotificationService class:
  # - initialize(sender) - dependency injection
  # - sender reader
  # - notify(recipient, message) - delegates to sender
  # - notify_all(recipients, message) - sends to multiple
  # - change_sender(new_sender) - allows runtime swap

  ##
  # High-level module depending on abstraction
  class NotificationService
    attr_reader :sender

    # NOTE: A MessageSender is passed in via dependency injection
    def initialize(sender)
      @sender = sender
    end

    def notify(recipient, message)
      @sender.send_message(recipient, message)
    end

    def notify_all(recipients, message)
      recipients.map do |recipient|
        notify(recipient, message)
      end
    end

    def change_sender(new_sender)
      @sender = new_sender
    end
  end

  # UserAlertSystem class:
  # - initialize(notification_service) - dependency injection
  # - send_alert(user, alert_type, details) - formats and sends
  # - send_welcome(user) - sends welcome message
  # - send_password_reset(user) - sends password reset message

  ##
  # Higher-level module using NotificationService
  class UserAlertSystem
    def initialize(notification_service)
      @notification_service = notification_service
    end

    def send_alert(user, alert_type, details)
      message = "[#{alert_type}] #{details}"
      @notification_service.notify(user, message)
    end

    def send_welcome(user)
      @notification_service.notify(user, "Welcome, #{user}!")
    end

    def send_password_reset(user)
      @notification_service.notify(user, "Hi, #{user}. Please change your password")
    end
  end
end
