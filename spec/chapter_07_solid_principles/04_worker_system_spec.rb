# frozen_string_literal: true

require 'chapter_07_solid_principles/04_worker_system'

RSpec.describe Chapter07::Workable do
  it 'defines a work method that raises NotImplementedError' do
    klass = Class.new { include Chapter07::Workable }
    expect { klass.new.work }.to raise_error(NotImplementedError)
  end
end

RSpec.describe Chapter07::Feedable do
  it 'defines an eat method that raises NotImplementedError' do
    klass = Class.new { include Chapter07::Feedable }
    expect { klass.new.eat }.to raise_error(NotImplementedError)
  end

  it 'defines a take_break method that raises NotImplementedError' do
    klass = Class.new { include Chapter07::Feedable }
    expect { klass.new.take_break }.to raise_error(NotImplementedError)
  end
end

RSpec.describe Chapter07::Sleepable do
  it 'defines a sleep method that raises NotImplementedError' do
    klass = Class.new { include Chapter07::Sleepable }
    expect { klass.new.sleep }.to raise_error(NotImplementedError)
  end
end

RSpec.describe Chapter07::HumanWorker do
  describe 'module inclusion' do
    it 'includes Workable, Feedable, and Sleepable' do
      expect(described_class.included_modules).to include(Chapter07::Workable)
      expect(described_class.included_modules).to include(Chapter07::Feedable)
      expect(described_class.included_modules).to include(Chapter07::Sleepable)
    end
  end

  describe '#initialize' do
    it 'creates a worker with a name' do
      worker = described_class.new('Alice')
      expect(worker.name).to eq('Alice')
    end
  end

  describe '#work' do
    it 'returns a working message' do
      worker = described_class.new('Alice')
      expect(worker.work).to eq('Alice is working')
    end
  end

  describe '#eat' do
    it 'returns an eating message' do
      worker = described_class.new('Alice')
      expect(worker.eat).to eq('Alice is eating lunch')
    end
  end

  describe '#take_break' do
    it 'returns a break message' do
      worker = described_class.new('Alice')
      expect(worker.take_break).to eq('Alice is taking a break')
    end
  end

  describe '#sleep' do
    it 'returns a sleeping message' do
      worker = described_class.new('Alice')
      expect(worker.sleep).to eq('Alice is sleeping')
    end
  end
end

RSpec.describe Chapter07::RobotWorker do
  describe 'module inclusion' do
    it 'includes only Workable' do
      expect(described_class.included_modules).to include(Chapter07::Workable)
      expect(described_class.included_modules).not_to include(Chapter07::Feedable)
      expect(described_class.included_modules).not_to include(Chapter07::Sleepable)
    end
  end

  describe '#initialize' do
    it 'creates a robot with a model' do
      robot = described_class.new('RX-78')
      expect(robot.model).to eq('RX-78')
    end
  end

  describe '#work' do
    it 'returns a working message' do
      robot = described_class.new('RX-78')
      expect(robot.work).to eq('Robot RX-78 is working')
    end
  end

  describe 'interface segregation' do
    it 'does not respond to eat' do
      robot = described_class.new('RX-78')
      expect(robot).not_to respond_to(:eat)
    end

    it 'does not respond to take_break' do
      robot = described_class.new('RX-78')
      expect(robot).not_to respond_to(:take_break)
    end

    it 'does not respond to sleep' do
      robot = described_class.new('RX-78')
      expect(robot).not_to respond_to(:sleep)
    end
  end
end

RSpec.describe Chapter07::ContractWorker do
  describe 'module inclusion' do
    it 'includes Workable and Feedable but not Sleepable' do
      expect(described_class.included_modules).to include(Chapter07::Workable)
      expect(described_class.included_modules).to include(Chapter07::Feedable)
      expect(described_class.included_modules).not_to include(Chapter07::Sleepable)
    end
  end

  describe '#initialize' do
    it 'creates a contractor with a name' do
      contractor = described_class.new('Bob')
      expect(contractor.name).to eq('Bob')
    end
  end

  describe '#work' do
    it 'returns a working message' do
      contractor = described_class.new('Bob')
      expect(contractor.work).to eq('Bob (contractor) is working')
    end
  end

  describe '#eat' do
    it 'returns an eating message' do
      contractor = described_class.new('Bob')
      expect(contractor.eat).to eq('Bob is eating')
    end
  end

  describe '#take_break' do
    it 'returns a break message' do
      contractor = described_class.new('Bob')
      expect(contractor.take_break).to eq('Bob is on break')
    end
  end

  describe 'interface segregation' do
    it 'does not respond to sleep' do
      contractor = described_class.new('Bob')
      expect(contractor).not_to respond_to(:sleep)
    end
  end
end

RSpec.describe Chapter07::WorkScheduler do
  describe '#initialize' do
    it 'accepts an array of workers' do
      human = Chapter07::HumanWorker.new('Alice')
      robot = Chapter07::RobotWorker.new('RX-78')
      scheduler = described_class.new([human, robot])

      expect(scheduler.workers).to eq([human, robot])
    end
  end

  describe '#assign_work' do
    it 'calls work on all workers and returns results' do
      human = Chapter07::HumanWorker.new('Alice')
      robot = Chapter07::RobotWorker.new('RX-78')
      scheduler = described_class.new([human, robot])

      results = scheduler.assign_work
      expect(results).to eq([
                              'Alice is working',
                              'Robot RX-78 is working'
                            ])
    end
  end
end

RSpec.describe Chapter07::BreakScheduler do
  describe '#initialize' do
    it 'accepts an array of workers' do
      human = Chapter07::HumanWorker.new('Alice')
      robot = Chapter07::RobotWorker.new('RX-78')
      contractor = Chapter07::ContractWorker.new('Bob')
      scheduler = described_class.new([human, robot, contractor])

      expect(scheduler.workers).to eq([human, robot, contractor])
    end
  end

  describe '#feedable_workers' do
    it 'returns only workers that include Feedable' do
      human = Chapter07::HumanWorker.new('Alice')
      robot = Chapter07::RobotWorker.new('RX-78')
      contractor = Chapter07::ContractWorker.new('Bob')
      scheduler = described_class.new([human, robot, contractor])

      feedable = scheduler.feedable_workers
      expect(feedable).to include(human)
      expect(feedable).to include(contractor)
      expect(feedable).not_to include(robot)
    end
  end

  describe '#schedule_breaks' do
    it 'calls take_break only on Feedable workers' do
      human = Chapter07::HumanWorker.new('Alice')
      robot = Chapter07::RobotWorker.new('RX-78')
      contractor = Chapter07::ContractWorker.new('Bob')
      scheduler = described_class.new([human, robot, contractor])

      results = scheduler.schedule_breaks
      expect(results).to eq([
                              'Alice is taking a break',
                              'Bob is on break'
                            ])
    end
  end
end
