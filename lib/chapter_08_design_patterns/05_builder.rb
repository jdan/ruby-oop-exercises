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
    attr_reader :cpu, :ram, :storage, :gpu

    def initialize(cpu:, ram:, storage:, gpu:)
      @cpu = cpu
      @ram = ram
      @storage = storage
      @gpu = gpu
    end

    def specs
      "CPU: #{cpu}, RAM: #{ram}, Storage: #{storage}, GPU: #{gpu || 'None'}"
    end
  end

  ##
  # Fluent builder for constructing Computer instances
  class ComputerBuilder
    # TODO: Implement ComputerBuilder
    #
    # Hints:
    # - Each set_* method should return self for chaining
    # - build should validate required fields before creating Computer
    def initialize
      @cpu = nil
      @ram = nil
      @storage = nil
      @gpu = nil
    end

    def set_cpu(cpu)
      @cpu = cpu
      self
    end

    def set_ram(ram)
      @ram = ram
      self
    end

    def set_storage(storage)
      @storage = storage
      self
    end

    def set_gpu(gpu)
      @gpu = gpu
      self
    end

    def build
      raise ArgumentError, 'CPU is required' unless @cpu
      raise ArgumentError, 'RAM is required' unless @ram
      raise ArgumentError, 'Storage is required' unless @storage

      Computer.new(cpu: @cpu, ram: @ram, storage: @storage, gpu: @gpu)
    end

    def reset
      @cpu = nil
      @ram = nil
      @storage = nil
      @gpu = nil
      self
    end
  end

  ##
  # Director that knows how to build specific computer configurations
  class ComputerDirector
    def initialize(builder)
      @builder = builder
    end

    def build_gaming_pc
      @builder
        .set_cpu('Intel i9-13900K')
        .set_ram('32GB DDR5')
        .set_storage('2TB NVMe SSD')
        .set_gpu('NVIDIA RTX 4090')
        .build
    end

    def build_office_pc
      @builder
        .set_cpu('Intel i5-13400')
        .set_ram('16GB DDR4')
        .set_storage('512GB SSD')
        .build
    end

    def build_workstation
      @builder
        .set_cpu('AMD Threadripper PRO')
        .set_ram('128GB ECC DDR5')
        .set_storage('4TB NVMe SSD')
        .set_gpu('NVIDIA RTX A6000')
        .build
    end
  end
end
