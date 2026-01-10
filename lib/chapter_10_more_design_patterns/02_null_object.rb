# frozen_string_literal: true

# Chapter 10: More Design Patterns
# Exercise 02: Null Object Pattern
#
# The Null Object pattern provides an object with neutral ("do nothing")
# behavior as a surrogate for the absence of an object. This eliminates
# the need for nil checks throughout your code.
#
# Implement the following:
#
# 1. ConsoleLogger class
#    - log(message) - returns "[LOG] #{message}"
#    - warn(message) - returns "[WARN] #{message}"
#    - error(message) - returns "[ERROR] #{message}"
#
# 2. NullLogger class
#    - Implements the same interface as ConsoleLogger
#    - log(message) - returns nil (does nothing)
#    - warn(message) - returns nil (does nothing)
#    - error(message) - returns nil (does nothing)
#
# 3. Application class
#    - initialize(logger: NullLogger.new) - accepts optional logger, defaults to NullLogger
#    - logger - attr_reader for the logger
#    - run - logs "Application starting", performs work, logs "Application finished"
#            returns "Operation complete"
#    - perform_operation(name) - logs "Performing operation: #{name}", returns name
#
# The key insight: Application never needs to check `if logger.nil?` because
# NullLogger always responds to the same methods as ConsoleLogger.

module Chapter10
  ##
  # A logger that outputs messages to the console
  class ConsoleLogger
    def log(message)
      "[LOG] #{message}"
    end

    def warn(message)
      "[WARN] #{message}"
    end

    def error(message)
      "[ERROR] #{message}"
    end
  end

  ##
  # A "do nothing" logger that silently ignores all messages
  class NullLogger
    def log(_) = nil
    def warn(_) = nil
    def error(_) = nil
  end

  ##
  # An application that uses a logger (defaults to NullLogger)
  class Application
    attr_reader :logger

    def initialize(logger: NullLogger.new)
      @logger = logger
    end

    def run
      @logger.log('Application starting')
      @logger.log('Application finished')
      'Operation complete'
    end

    def perform_operation(name)
      @logger.log("Performing operation: #{name}")
      name
    end
  end
end
