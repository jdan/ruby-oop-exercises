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
