# frozen_string_literal: true

# Chapter 08: Design Patterns
# Exercise 03: Observer Pattern
#
# The Observer Pattern defines a one-to-many dependency between objects.
# When the subject changes state, all observers are notified automatically.
#
# Implement the following:
#
# 1. EventEmitter module (to be included in classes)
#    - subscribe(event, &block) - register a callback for an event
#    - unsubscribe(event, &block) - remove a callback
#    - emit(event, *args) - notify all subscribers, passing args to callbacks
#
# 2. NewsPublisher class (includes EventEmitter)
#    - initialize(name) - creates publisher with a name
#    - name - returns the publisher name
#    - publish(article) - emits :news event with the article
#
# 3. NewsSubscriber class
#    - initialize(name) - creates subscriber with a name
#    - name - returns the subscriber name
#    - follow(publisher) - subscribes to publisher's :news events
#    - unfollow(publisher) - unsubscribes from publisher
#    - received_articles - returns array of all received articles

module Chapter08
  ##
  # A mixin that provides publish-subscribe event functionality
  module EventEmitter
    # TODO: Implement subscribe, unsubscribe, emit
    #
    # Hints:
    # - Store callbacks in a Hash where keys are event names
    # - Each event maps to an array of callback procs
  end

  ##
  # A news publisher that emits articles to subscribers
  class NewsPublisher
    # TODO: Include EventEmitter and implement publisher
  end

  ##
  # A subscriber that follows publishers and collects articles
  class NewsSubscriber
    # TODO: Implement subscriber
    #
    # Hints:
    # - Store a reference to callbacks so you can unsubscribe later
    # - Use method(:receive_article).to_proc to create a callback
  end
end
