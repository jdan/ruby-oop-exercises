# frozen_string_literal: true

# Implement the channel classes and NotificationDispatcher here
#
# This exercise demonstrates polymorphism with notification channels.
# All channels share: deliver(recipient, subject, body), channel_name, supports_html?
#
# EmailChannel class:
# - deliver(recipient, subject, body) returns:
#   "EMAIL to #{recipient} | Subject: #{subject} | Body: #{body}"
# - channel_name returns "email"
# - supports_html? returns true
#
# SmsChannel class:
# - deliver(recipient, subject, body) returns:
#   "SMS to #{recipient} | #{body}" (ignores subject)
# - channel_name returns "sms"
# - supports_html? returns false
#
# SlackChannel class:
# - deliver(recipient, subject, body) returns:
#   "SLACK to #{recipient} | *#{subject}* | #{body}"
# - channel_name returns "slack"
# - supports_html? returns false
#
# PushChannel class:
# - deliver(recipient, subject, body) returns:
#   "PUSH to #{recipient} | Title: #{subject} | #{body}"
# - channel_name returns "push"
# - supports_html? returns false
#
# NotificationDispatcher class:
# - initialize(channels) - accepts array of channel objects
# - channels reader
# - send_to_all(recipient, subject, body) - delivers via all channels, returns array of results
# - send_via(channel_name, recipient, subject, body) - delivers via specific channel, returns result or nil
# - html_capable_channels - returns array of channels where supports_html? is true
# - available_channels - returns array of channel names (strings)
