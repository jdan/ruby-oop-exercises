# frozen_string_literal: true

# Implement the Employee class hierarchy here
#
# Employee (base class):
# - initialize(name, base_salary)
# - name reader
# - salary_info returns "Name: {name}, Salary: ${base_salary}"
#
# Manager (inherits from Employee):
# - initialize(name, base_salary, bonus)
# - salary_info returns "Name: {name}, Salary: ${base_salary}, Bonus: ${bonus}"
# - total_compensation returns base_salary + bonus
#
# Intern (inherits from Employee):
# - initialize(name, base_salary, school)
# - salary_info returns "Name: {name}, Salary: ${base_salary}, School: {school}"
# - school reader

module Chapter03
  ##
  # An employee with a name and base salary
  class Employee
    attr_reader :name

    def initialize(name, base_salary)
      @name = name
      @base_salary = base_salary
    end

    def salary_info
      "Name: #{name}, Salary: $#{@base_salary}"
    end
  end

  ##
  # A manager is an employee who receives a bonus
  class Manager < Employee
    def initialize(name, base_salary, bonus)
      super(name, base_salary)
      @bonus = bonus
    end

    def salary_info
      "Name: #{name}, Salary: $#{@base_salary}, Bonus: $#{@bonus}"
    end

    def total_compensation
      @base_salary + @bonus
    end
  end

  ##
  # An intern is an employee who goes to a school
  class Intern < Employee
    attr_reader :school

    def initialize(name, base_salary, school)
      super(name, base_salary)
      @school = school
    end

    def salary_info
      "Name: #{name}, Salary: $#{@base_salary}, School: #{school}"
    end
  end
end
