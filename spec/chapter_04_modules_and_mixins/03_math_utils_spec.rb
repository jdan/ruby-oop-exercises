# frozen_string_literal: true

require 'chapter_04_modules_and_mixins/03_math_utils'

RSpec.describe Chapter04::MathUtils do
  describe '.square' do
    it 'returns the square of a number' do
      expect(described_class.square(4)).to eq(16)
    end

    it 'handles zero' do
      expect(described_class.square(0)).to eq(0)
    end

    it 'handles negative numbers' do
      expect(described_class.square(-3)).to eq(9)
    end
  end

  describe '.cube' do
    it 'returns the cube of a number' do
      expect(described_class.cube(3)).to eq(27)
    end

    it 'handles zero' do
      expect(described_class.cube(0)).to eq(0)
    end

    it 'handles negative numbers' do
      expect(described_class.cube(-2)).to eq(-8)
    end
  end

  describe '.factorial' do
    it 'returns 1 for factorial of 0' do
      expect(described_class.factorial(0)).to eq(1)
    end

    it 'returns 1 for factorial of 1' do
      expect(described_class.factorial(1)).to eq(1)
    end

    it 'returns the factorial of a number' do
      expect(described_class.factorial(5)).to eq(120)
    end

    it 'handles larger numbers' do
      expect(described_class.factorial(10)).to eq(3_628_800)
    end
  end
end

RSpec.describe Chapter04::Calculator do
  describe '.power_summary' do
    it 'returns a hash with square and cube' do
      result = described_class.power_summary(3)

      expect(result).to eq({ square: 9, cube: 27 })
    end

    it 'works with different numbers' do
      result = described_class.power_summary(5)

      expect(result).to eq({ square: 25, cube: 125 })
    end

    it 'handles zero' do
      result = described_class.power_summary(0)

      expect(result).to eq({ square: 0, cube: 0 })
    end
  end

  describe 'module extension' do
    it 'extends MathUtils for class-level access' do
      expect(described_class.singleton_class.included_modules).to include(Chapter04::MathUtils)
    end
  end
end
