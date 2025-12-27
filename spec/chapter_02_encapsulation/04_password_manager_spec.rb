# frozen_string_literal: true

require 'chapter_02_encapsulation/04_password_manager'

RSpec.describe PasswordManager do
  describe '#initialize' do
    it 'creates a password manager with a password' do
      pm = PasswordManager.new('secret123')
      expect(pm).to be_a(PasswordManager)
    end
  end

  describe '#authenticate' do
    it 'returns true for correct password' do
      pm = PasswordManager.new('secret123')
      expect(pm.authenticate('secret123')).to be true
    end

    it 'returns false for incorrect password' do
      pm = PasswordManager.new('secret123')
      expect(pm.authenticate('wrongpassword')).to be false
    end

    it 'is case-sensitive' do
      pm = PasswordManager.new('Secret123')
      expect(pm.authenticate('secret123')).to be false
    end
  end

  describe '#change_password' do
    it 'returns true and changes password when old password is correct' do
      pm = PasswordManager.new('secret123')
      result = pm.change_password('secret123', 'newpass456')
      expect(result).to be true
      expect(pm.authenticate('newpass456')).to be true
    end

    it 'returns false and keeps old password when old password is wrong' do
      pm = PasswordManager.new('secret123')
      result = pm.change_password('wrongpass', 'newpass456')
      expect(result).to be false
      expect(pm.authenticate('secret123')).to be true
    end

    it 'old password no longer works after change' do
      pm = PasswordManager.new('secret123')
      pm.change_password('secret123', 'newpass456')
      expect(pm.authenticate('secret123')).to be false
    end
  end

  describe 'password encapsulation' do
    it 'does not expose password through instance variables' do
      pm = PasswordManager.new('secret123')
      expect(pm.instance_variables).not_to be_empty
      # Password should not be directly readable
      expect { pm.password }.to raise_error(NoMethodError)
    end

    it 'does not have a password reader method' do
      pm = PasswordManager.new('secret123')
      expect(pm).not_to respond_to(:password)
    end

    it 'does not have a password writer method' do
      pm = PasswordManager.new('secret123')
      expect(pm).not_to respond_to(:password=)
    end
  end
end
