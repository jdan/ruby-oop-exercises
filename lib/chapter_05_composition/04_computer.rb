# frozen_string_literal: true

Cpu = Struct.new(:model, :cores) do
  def specs
    "#{model} (#{cores} cores)"
  end
end

Memory = Struct.new(:size_gb) do
  def specs
    "#{size_gb}GB RAM"
  end
end

Storage = Struct.new(:size_gb, :storage_type) do
  def specs
    "#{size_gb}GB #{storage_type}"
  end
end

##
# A computer with a CPU, memory, and storage
class Computer
  attr_reader :cpu, :memory, :storage

  def initialize(cpu, memory, storage)
    @cpu = cpu
    @memory = memory
    @storage = storage
  end

  def full_specs
    "CPU: #{cpu.specs}, Memory: #{memory.specs}, Storage: #{storage.specs}"
  end

  def upgrade_memory(new_memory)
    @memory = new_memory
  end

  def upgrade_storage(new_storage)
    @storage = new_storage
  end

  def total_storage_and_memory
    @memory.size_gb + @storage.size_gb
  end
end
