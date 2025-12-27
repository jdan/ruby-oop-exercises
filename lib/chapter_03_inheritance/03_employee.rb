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

class Employee
end

class Manager < Employee
end

class Intern < Employee
end
