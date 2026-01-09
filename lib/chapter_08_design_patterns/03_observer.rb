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
    def callbacks
      @callbacks ||= {}
    end

    def subscribe(event, &block)
      callbacks[event] ||= []
      callbacks[event] << block
    end

    def unsubscribe(event, &block)
      return unless callbacks[event]

      callbacks[event].delete(block)
    end

    def emit(event, *)
      return unless callbacks[event]

      callbacks[event].each do |cb|
        cb.call(*)
      end
    end
  end

  ##
  # A news publisher that emits articles to subscribers
  class NewsPublisher
    include EventEmitter

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def publish(article)
      emit(:news, article)
    end
  end

  ##
  # A subscriber that follows publishers and collects articles
  class NewsSubscriber
    attr_reader :name, :received_articles

    def initialize(name)
      @name = name
      @subscriptions = {}
      @received_articles = []
    end

    def follow(publisher)
      method = method(:receive_article).to_proc

      @subscriptions[publisher] = method
      publisher.subscribe(:news, &method)
    end

    def receive_article(article)
      @received_articles << article
    end

    def unfollow(publisher)
      method = @subscriptions[publisher]
      @subscriptions.delete publisher
      publisher.unsubscribe(:news, &method)
    end
  end
end
