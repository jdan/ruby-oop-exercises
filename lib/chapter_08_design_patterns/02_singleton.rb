# frozen_string_literal: true

# Chapter 08: Design Patterns
# Exercise 02: Singleton Pattern
#
# The Singleton Pattern ensures a class has only one instance and provides
# a global point of access to it. Useful for configuration, logging, etc.
#
# Implement a Configuration class that:
#
# 1. Has a private constructor (new should raise NoMethodError)
# 2. Provides .instance class method to get the single instance
# 3. Stores key-value configuration:
#    - set(key, value) - stores a value
#    - get(key) - retrieves a value (nil if not set)
#    - all - returns all config as a hash
# 4. Provides .reset! class method to clear config (useful for testing)

module Chapter08
  ##
  # A singleton configuration store
  class Configuration
    private_class_method :new

    @mutex = Mutex.new

    def initialize
      @hash = {}
    end

    def self.instance
      @mutex.synchronize do
        @instance ||= new
      end
    end

    def set(key, value)
      @hash[key] = value
    end

    def get(key)
      @hash[key]
    end

    def all
      @hash
    end

    def self.reset!
      @mutex.synchronize do
        @instance = new
      end
    end
  end
end
