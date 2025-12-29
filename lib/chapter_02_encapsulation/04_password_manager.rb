# frozen_string_literal: true

# Implement the PasswordManager class here
#
# A PasswordManager should:
# - Be initialized with a password (stored privately, never exposed)
# - Have an authenticate(attempt) method that returns true/false
# - Have a change_password(old_password, new_password) method
#   - Returns true and changes password if old_password is correct
#   - Returns false and keeps old password if old_password is wrong
# - The password should NEVER be accessible from outside the class

module Chapter02
  ##
  # A password manager which does not expose a password to callers
  class PasswordManager
    def initialize(password)
      @password = password
    end

    def authenticate(attempt)
      attempt == @password
    end

    def change_password(old_password, new_password)
      return false unless authenticate(old_password)

      @password = new_password
      true
    end
  end
end
