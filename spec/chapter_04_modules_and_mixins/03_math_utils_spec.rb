# frozen_string_literal: true

require 'chapter_04_modules_and_mixins/03_math_utils'

RSpec.describe MathUtils do
  describe '.square' do
    it 'returns the square of a number' do
      expect(MathUtils.square(4)).to eq(16)
    end

    it 'handles zero' do
      expect(MathUtils.square(0)).to eq(0)
    end

    it 'handles negative numbers' do
      expect(MathUtils.square(-3)).to eq(9)
    end
  end

  describe '.cube' do
    it 'returns the cube of a number' do
      expect(MathUtils.cube(3)).to eq(27)
    end

    it 'handles zero' do
      expect(MathUtils.cube(0)).to eq(0)
    end

    it 'handles negative numbers' do
      expect(MathUtils.cube(-2)).to eq(-8)
    end
  end

  describe '.factorial' do
    it 'returns 1 for factorial of 0' do
      expect(MathUtils.factorial(0)).to eq(1)
    end

    it 'returns 1 for factorial of 1' do
      expect(MathUtils.factorial(1)).to eq(1)
    end

    it 'returns the factorial of a number' do
      expect(MathUtils.factorial(5)).to eq(120)
    end

    it 'handles larger numbers' do
      expect(MathUtils.factorial(10)).to eq(3_628_800)
    end
  end
end

RSpec.describe Calculator do
  describe '.power_summary' do
    it 'returns a hash with square and cube' do
      result = Calculator.power_summary(3)

      expect(result).to eq({ square: 9, cube: 27 })
    end

    it 'works with different numbers' do
      result = Calculator.power_summary(5)

      expect(result).to eq({ square: 25, cube: 125 })
    end

    it 'handles zero' do
      result = Calculator.power_summary(0)

      expect(result).to eq({ square: 0, cube: 0 })
    end
  end

  describe 'module extension' do
    it 'extends MathUtils for class-level access' do
      expect(Calculator.singleton_class.included_modules).to include(MathUtils)
    end
  end
end
