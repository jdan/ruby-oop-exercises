# frozen_string_literal: true

# Chapter 08: Design Patterns
# Exercise 05: Builder Pattern
#
# The Builder Pattern separates the construction of a complex object from
# its representation. It allows step-by-step construction with a fluent API.
#
# Implement the following:
#
# 1. Computer class (the product)
#    - initialize(cpu:, ram:, storage:, gpu:) - keyword arguments
#    - cpu, ram, storage, gpu - attribute readers
#    - specs - returns formatted string of all components
#      Format: "CPU: X, RAM: Y, Storage: Z, GPU: W" (or "GPU: None" if nil)
#
# 2. ComputerBuilder class (fluent builder)
#    - set_cpu(cpu) - sets CPU, returns self
#    - set_ram(ram) - sets RAM, returns self
#    - set_storage(storage) - sets storage, returns self
#    - set_gpu(gpu) - sets GPU (optional), returns self
#    - build - returns a Computer instance, raises ArgumentError if required
#              fields (cpu, ram, storage) are missing
#    - reset - clears all settings, returns self
#
# 3. ComputerDirector class (predefined configurations)
#    - initialize(builder) - stores the builder
#    - build_gaming_pc - returns a high-end gaming computer
#      (Intel i9-13900K, 32GB DDR5, 2TB NVMe SSD, NVIDIA RTX 4090)
#    - build_office_pc - returns a basic office computer
#      (Intel i5-13400, 16GB DDR4, 512GB SSD, no GPU)
#    - build_workstation - returns a professional workstation
#      (AMD Threadripper PRO, 128GB ECC DDR5, 4TB NVMe SSD, NVIDIA RTX A6000)

module Chapter08
  ##
  # A computer with various components
  class Computer
    # TODO: Implement Computer
  end

  ##
  # Fluent builder for constructing Computer instances
  class ComputerBuilder
    # TODO: Implement ComputerBuilder
    #
    # Hints:
    # - Each set_* method should return self for chaining
    # - build should validate required fields before creating Computer
  end

  ##
  # Director that knows how to build specific computer configurations
  class ComputerDirector
    # TODO: Implement ComputerDirector
  end
end
