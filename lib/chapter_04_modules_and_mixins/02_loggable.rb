# frozen_string_literal: true

# Implement the Loggable module and the Application class here
#
# The Loggable module should:
# - Define a `log(message)` method that adds timestamped entries to a log
# - Define a `log_history` method that returns all logged messages
# - Store logs as "[TIMESTAMP] message" where TIMESTAMP is Time.now
#
# The Application class should:
# - Include the Loggable module
# - Accept a name in the constructor
# - Have a `name` reader method
# - Have a `start` method that logs "Application #{name} started"
# - Have a `stop` method that logs "Application #{name} stopped"

##
# A module that provides logging functionality
module Loggable
end

##
# An application that can log its activity
class Application
end
