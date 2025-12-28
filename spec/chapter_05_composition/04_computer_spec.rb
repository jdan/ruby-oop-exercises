# frozen_string_literal: true

require 'chapter_05_composition/04_computer'

RSpec.describe Cpu do
  describe '#initialize' do
    it 'creates a CPU with model and cores' do
      cpu = Cpu.new('Intel i7', 8)

      expect(cpu.model).to eq('Intel i7')
      expect(cpu.cores).to eq(8)
    end
  end

  describe '#specs' do
    it 'returns CPU specifications' do
      cpu = Cpu.new('AMD Ryzen 9', 12)

      expect(cpu.specs).to eq('AMD Ryzen 9 (12 cores)')
    end
  end
end

RSpec.describe Memory do
  describe '#initialize' do
    it 'creates memory with size in GB' do
      memory = Memory.new(16)

      expect(memory.size_gb).to eq(16)
    end
  end

  describe '#specs' do
    it 'returns memory specifications' do
      memory = Memory.new(32)

      expect(memory.specs).to eq('32GB RAM')
    end
  end
end

RSpec.describe Storage do
  describe '#initialize' do
    it 'creates storage with size and type' do
      storage = Storage.new(512, 'SSD')

      expect(storage.size_gb).to eq(512)
      expect(storage.storage_type).to eq('SSD')
    end
  end

  describe '#specs' do
    it 'returns storage specifications' do
      storage = Storage.new(1000, 'HDD')

      expect(storage.specs).to eq('1000GB HDD')
    end
  end
end

RSpec.describe Computer do
  let(:cpu) { Cpu.new('Intel i7', 8) }
  let(:memory) { Memory.new(16) }
  let(:storage) { Storage.new(512, 'SSD') }

  describe '#initialize' do
    it 'creates a computer with CPU, memory, and storage' do
      computer = Computer.new(cpu, memory, storage)

      expect(computer.cpu).to eq(cpu)
      expect(computer.memory).to eq(memory)
      expect(computer.storage).to eq(storage)
    end
  end

  describe '#full_specs' do
    it 'returns complete computer specifications' do
      computer = Computer.new(cpu, memory, storage)

      expected = 'CPU: Intel i7 (8 cores), Memory: 16GB RAM, Storage: 512GB SSD'
      expect(computer.full_specs).to eq(expected)
    end
  end

  describe '#upgrade_memory' do
    it 'replaces the memory component' do
      computer = Computer.new(cpu, memory, storage)
      new_memory = Memory.new(32)

      computer.upgrade_memory(new_memory)

      expect(computer.memory.size_gb).to eq(32)
    end
  end

  describe '#upgrade_storage' do
    it 'replaces the storage component' do
      computer = Computer.new(cpu, memory, storage)
      new_storage = Storage.new(1000, 'NVMe')

      computer.upgrade_storage(new_storage)

      expect(computer.storage.size_gb).to eq(1000)
      expect(computer.storage.storage_type).to eq('NVMe')
    end
  end

  describe '#total_storage_and_memory' do
    it 'returns sum of memory and storage in GB' do
      computer = Computer.new(cpu, memory, storage)

      expect(computer.total_storage_and_memory).to eq(528)
    end
  end
end
