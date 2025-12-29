# frozen_string_literal: true

# Dependency Inversion Principle (DIP)
#
# High-level modules should not depend on low-level modules.
# Both should depend on abstractions.
#
# NotificationService depends on the MessageSender abstraction,
# not on concrete EmailSender, SmsSender, etc. implementations.
# Dependencies are injected, not instantiated internally.

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
end

# SmsSender class:
# - includes MessageSender
# - initialize(api_key: "default_key")
# - api_key reader
# - send_message(recipient, message) - returns "SMS sent to X: Y"

##
# Concrete implementation for SMS
class SmsSender
end

# PushSender class:
# - includes MessageSender
# - initialize(app_id: "default_app")
# - app_id reader
# - send_message(recipient, message) - returns "Push sent to X from Y: Z"

##
# Concrete implementation for push notifications
class PushSender
end

# MockSender class:
# - includes MessageSender
# - initialize (creates empty messages array)
# - messages reader (returns array of {recipient:, message:} hashes)
# - send_message(recipient, message) - stores and returns "Mock: X"

##
# Test double for unit testing (demonstrates easy testing with DIP)
class MockSender
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
end

# UserAlertSystem class:
# - initialize(notification_service) - dependency injection
# - send_alert(user, alert_type, details) - formats and sends
# - send_welcome(user) - sends welcome message
# - send_password_reset(user) - sends password reset message

##
# Higher-level module using NotificationService
class UserAlertSystem
end
