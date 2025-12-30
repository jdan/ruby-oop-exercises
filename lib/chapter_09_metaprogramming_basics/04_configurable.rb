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
    # TODO: Initialize with an empty settings hash
    # TODO: Implement method_missing to handle dynamic getters/setters
    # TODO: Implement respond_to_missing?
  end

  ##
  # Module that adds configuration DSL to any class
  module Configurable
    # TODO: Use self.included(base) to extend the including class
    # Hint: base.extend(ClassMethods)

    # module ClassMethods
    #   TODO: Implement configure { |config| ... }
    #   TODO: Implement config (returns the Configuration instance)
    #   TODO: Implement reset_configuration
    # end
  end

  ##
  # Example class using the Configurable module
  class AppSettings
    # TODO: Include Configurable
  end
end
