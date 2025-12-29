# frozen_string_literal: true

# Implement the channel classes and NotificationDispatcher here
#
# This exercise demonstrates polymorphism with notification channels.
# All channels share: deliver(recipient, subject, body), channel_name, supports_html?

##
# An email dispatcher
class EmailChannel
  def deliver(recipient, subject, body)
    "EMAIL to #{recipient} | Subject: #{subject} | Body: #{body}"
  end

  def channel_name = 'email'
  def supports_html? = true
end

#
# SmsChannel class:
# - deliver(recipient, subject, body) returns:
#   "SMS to #{recipient} | #{body}" (ignores subject)
# - channel_name returns "sms"
# - supports_html? returns false

##
# An SMS dispatcher
class SmsChannel
  def deliver(recipient, _, body)
    "SMS to #{recipient} | #{body}"
  end

  def channel_name = 'sms'
  def supports_html? = false
end

#
# SlackChannel class:
# - deliver(recipient, subject, body) returns:
#   "SLACK to #{recipient} | *#{subject}* | #{body}"
# - channel_name returns "slack"
# - supports_html? returns false

##
# A Slack dispatcher
class SlackChannel
  def deliver(recipient, subject, body)
    "SLACK to #{recipient} | *#{subject}* | #{body}"
  end

  def channel_name = 'slack'
  def supports_html? = false
end

#
# PushChannel class:
# - deliver(recipient, subject, body) returns:
#   "PUSH to #{recipient} | Title: #{subject} | #{body}"
# - channel_name returns "push"
# - supports_html? returns false

##
# A push notification dispatcher
class PushChannel
  def deliver(recipient, subject, body)
    "PUSH to #{recipient} | Title: #{subject} | #{body}"
  end

  def channel_name = 'push'
  def supports_html? = false
end

##
# A notification dispatcher
class NotificationDispatcher
  attr_reader :channels

  def initialize(channels)
    @channels = channels
  end

  def send_to_all(recipient, subject, body)
    @channels.map do |channel|
      channel.deliver(recipient, subject, body)
    end
  end

  def send_via(channel_name, recipient, subject, body)
    @channels
      .find { |channel| channel.channel_name == channel_name }
      &.deliver(recipient, subject, body)
  end

  def html_capable_channels
    @channels.filter &:supports_html?
  end

  def available_channels
    @channels.map &:channel_name
  end
end
