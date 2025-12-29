# frozen_string_literal: true

# Implement the Sender classes and NotificationService here
#
# This exercise demonstrates composition with multiple collaborators:
# NotificationService composes multiple sender objects.
#
# EmailSender class:
# - send_message(recipient, message) returns "Email to #{recipient}: #{message}"
#
# SmsSender class:
# - send_message(recipient, message) returns "SMS to #{recipient}: #{message}"
#
# PushNotificationSender class:
# - send_message(recipient, message) returns "Push to #{recipient}: #{message}"
#
# NotificationService class:
# - initialize(senders) - accepts an array of sender objects
# - senders reader
# - notify(recipient, message) - calls send_message on all senders, returns array of results
# - add_sender(sender) - adds a sender to the list
# - remove_sender(sender) - removes a sender from the list

module Chapter05
  ##
  # An email sender
  class EmailSender
    def send_message(recipient, message)
      "Email to #{recipient}: #{message}"
    end
  end

  ##
  # An SMS sender
  class SmsSender
    def send_message(recipient, message)
      "SMS to #{recipient}: #{message}"
    end
  end

  ##
  # A push notification sender
  class PushNotificationSender
    def send_message(recipient, message)
      "Push to #{recipient}: #{message}"
    end
  end

  ##
  # A notification service
  # - notify(recipient, message) - calls send_message on all senders, returns array of results
  # - add_sender(sender) - adds a sender to the list
  # - remove_sender(sender) - removes a sender from the list
  class NotificationService
    attr_reader :senders

    def initialize(senders)
      @senders = senders
    end

    def notify(recipient, message)
      @senders.map do |sender|
        sender.send_message(recipient, message)
      end
    end

    def add_sender(sender)
      @senders << sender
    end

    def remove_sender(sender)
      @senders.delete sender
    end
  end
end
