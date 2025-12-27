# frozen_string_literal: true

require 'chapter_03_inheritance/03_employee'

RSpec.describe 'Employee hierarchy' do
  describe Employee do
    it 'can be created with name and base salary' do
      emp = Employee.new('John', 50_000)
      expect(emp.name).to eq('John')
    end

    it 'has a salary_info method' do
      emp = Employee.new('John', 50_000)
      expect(emp.salary_info).to eq('Name: John, Salary: $50000')
    end
  end

  describe Manager do
    it 'inherits from Employee' do
      expect(Manager.superclass).to eq(Employee)
    end

    it 'can be created with name, base salary, and bonus' do
      manager = Manager.new('Sarah', 80_000, 15_000)
      expect(manager.name).to eq('Sarah')
    end

    it 'overrides salary_info to include bonus' do
      manager = Manager.new('Sarah', 80_000, 15_000)
      expect(manager.salary_info).to eq('Name: Sarah, Salary: $80000, Bonus: $15000')
    end

    it 'has a total_compensation method' do
      manager = Manager.new('Sarah', 80_000, 15_000)
      expect(manager.total_compensation).to eq(95_000)
    end

    it 'is an Employee' do
      manager = Manager.new('Sarah', 80_000, 15_000)
      expect(manager).to be_a(Employee)
    end
  end

  describe Intern do
    it 'inherits from Employee' do
      expect(Intern.superclass).to eq(Employee)
    end

    it 'can be created with name, base salary, and school' do
      intern = Intern.new('Alex', 30_000, 'MIT')
      expect(intern.name).to eq('Alex')
      expect(intern.school).to eq('MIT')
    end

    it 'overrides salary_info to include school' do
      intern = Intern.new('Alex', 30_000, 'MIT')
      expect(intern.salary_info).to eq('Name: Alex, Salary: $30000, School: MIT')
    end

    it 'is an Employee' do
      intern = Intern.new('Alex', 30_000, 'MIT')
      expect(intern).to be_a(Employee)
    end
  end
end
