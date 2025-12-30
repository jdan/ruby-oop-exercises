# frozen_string_literal: true

require 'chapter_08_design_patterns/05_builder'

RSpec.describe Chapter08::Computer do
  describe '#initialize' do
    it 'creates a computer with components' do
      computer = described_class.new(
        cpu: 'Intel i7',
        ram: '16GB',
        storage: '512GB SSD',
        gpu: 'NVIDIA RTX 3080'
      )

      expect(computer.cpu).to eq('Intel i7')
      expect(computer.ram).to eq('16GB')
      expect(computer.storage).to eq('512GB SSD')
      expect(computer.gpu).to eq('NVIDIA RTX 3080')
    end

    it 'allows nil for optional components' do
      computer = described_class.new(
        cpu: 'AMD Ryzen 5',
        ram: '8GB',
        storage: '256GB SSD',
        gpu: nil
      )

      expect(computer.gpu).to be_nil
    end
  end

  describe '#specs' do
    it 'returns a formatted string of all components' do
      computer = described_class.new(
        cpu: 'Intel i9',
        ram: '32GB',
        storage: '1TB SSD',
        gpu: 'NVIDIA RTX 4090'
      )

      expect(computer.specs).to eq(
        'CPU: Intel i9, RAM: 32GB, Storage: 1TB SSD, GPU: NVIDIA RTX 4090'
      )
    end

    it 'shows "None" for missing GPU' do
      computer = described_class.new(
        cpu: 'Intel i5',
        ram: '8GB',
        storage: '256GB SSD',
        gpu: nil
      )

      expect(computer.specs).to eq(
        'CPU: Intel i5, RAM: 8GB, Storage: 256GB SSD, GPU: None'
      )
    end
  end
end

RSpec.describe Chapter08::ComputerBuilder do
  describe '#set_cpu' do
    it 'sets the CPU and returns self for chaining' do
      builder = described_class.new
      result = builder.set_cpu('Intel i7')
      expect(result).to be(builder)
    end
  end

  describe '#set_ram' do
    it 'sets the RAM and returns self for chaining' do
      builder = described_class.new
      result = builder.set_ram('16GB')
      expect(result).to be(builder)
    end
  end

  describe '#set_storage' do
    it 'sets the storage and returns self for chaining' do
      builder = described_class.new
      result = builder.set_storage('512GB SSD')
      expect(result).to be(builder)
    end
  end

  describe '#set_gpu' do
    it 'sets the GPU and returns self for chaining' do
      builder = described_class.new
      result = builder.set_gpu('NVIDIA RTX 3080')
      expect(result).to be(builder)
    end
  end

  describe '#build' do
    it 'creates a Computer with the specified components' do
      computer = described_class.new
                                .set_cpu('AMD Ryzen 9')
                                .set_ram('64GB')
                                .set_storage('2TB NVMe')
                                .set_gpu('AMD RX 7900')
                                .build

      expect(computer).to be_a(Chapter08::Computer)
      expect(computer.cpu).to eq('AMD Ryzen 9')
      expect(computer.ram).to eq('64GB')
      expect(computer.storage).to eq('2TB NVMe')
      expect(computer.gpu).to eq('AMD RX 7900')
    end

    it 'allows building without GPU' do
      computer = described_class.new
                                .set_cpu('Intel i3')
                                .set_ram('4GB')
                                .set_storage('128GB SSD')
                                .build

      expect(computer.gpu).to be_nil
    end

    it 'raises error if CPU is not set' do
      builder = described_class.new
                               .set_ram('8GB')
                               .set_storage('256GB SSD')

      expect { builder.build }.to raise_error(ArgumentError, /CPU is required/)
    end

    it 'raises error if RAM is not set' do
      builder = described_class.new
                               .set_cpu('Intel i5')
                               .set_storage('256GB SSD')

      expect { builder.build }.to raise_error(ArgumentError, /RAM is required/)
    end

    it 'raises error if storage is not set' do
      builder = described_class.new
                               .set_cpu('Intel i5')
                               .set_ram('8GB')

      expect { builder.build }.to raise_error(ArgumentError, /Storage is required/)
    end
  end

  describe '#reset' do
    it 'clears all settings and returns self' do
      builder = described_class.new
                               .set_cpu('Intel i7')
                               .set_ram('16GB')
                               .reset

      expect { builder.build }.to raise_error(ArgumentError)
    end
  end
end

RSpec.describe Chapter08::ComputerDirector do
  let(:builder) { Chapter08::ComputerBuilder.new }
  let(:director) { described_class.new(builder) }

  describe '#build_gaming_pc' do
    it 'builds a high-end gaming computer' do
      computer = director.build_gaming_pc

      expect(computer.cpu).to eq('Intel i9-13900K')
      expect(computer.ram).to eq('32GB DDR5')
      expect(computer.storage).to eq('2TB NVMe SSD')
      expect(computer.gpu).to eq('NVIDIA RTX 4090')
    end
  end

  describe '#build_office_pc' do
    it 'builds a basic office computer' do
      computer = director.build_office_pc

      expect(computer.cpu).to eq('Intel i5-13400')
      expect(computer.ram).to eq('16GB DDR4')
      expect(computer.storage).to eq('512GB SSD')
      expect(computer.gpu).to be_nil
    end
  end

  describe '#build_workstation' do
    it 'builds a professional workstation' do
      computer = director.build_workstation

      expect(computer.cpu).to eq('AMD Threadripper PRO')
      expect(computer.ram).to eq('128GB ECC DDR5')
      expect(computer.storage).to eq('4TB NVMe SSD')
      expect(computer.gpu).to eq('NVIDIA RTX A6000')
    end
  end
end
