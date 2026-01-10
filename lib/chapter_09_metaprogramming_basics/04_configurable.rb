# frozen_string_literal: true

# Chapter 09: Metaprogramming Basics
# Exercise 04: Configurable Module
#
# Many Ruby gems use a configuration DSL that lets you write clean,
# readable configuration blocks. This exercise creates a configuration
# system using instance_eval and method_missing.
#
# Implement the following:
#
# 1. Configuration class
#    - Stores arbitrary settings in a hash
#    - method_missing to handle getter/setter calls dynamically
#      - foo= stores a value, foo retrieves it
#    - respond_to_missing? to return true for any method
#
# 2. Configurable module
#    - When included, add configure and config class methods
#    - configure yields or instance_evals a block with the config object
#    - config returns the Configuration instance
#    - reset_configuration creates a fresh Configuration
#
# 3. AppSettings class
#    - Include Configurable
#    - Support syntax like:
#      AppSettings.configure do |config|
#        config.app_name = 'MyApp'
#        config.max_connections = 10
#      end

module Chapter09
  ##
  # Stores configuration settings dynamically using method_missing
  class Configuration
    def initialize
      @config = {}
    end

    def method_missing(method, *args)
      if method.to_s.end_with?('=')
        @config[method.to_s[..-2].to_sym] = args.first
      else
        @config[method]
      end
    end

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end
  end

  ##
  # Module that adds configuration DSL to any class
  module Configurable
    def self.included(base)
      base.extend(ClassMethods)
    end

    ##
    # Utility module to define configuration
    module ClassMethods
      def config
        @config ||= Configuration.new
      end

      def configure
        @config ||= Configuration.new
        # NOTE: We simply yield to the `configure do |config| .. end` block with `@config`
        yield @config
      end

      def reset_configuration
        @config = Configuration.new
      end
    end
  end

  ##
  # Example class using the Configurable module
  class AppSettings
    include Configurable
  end
end
