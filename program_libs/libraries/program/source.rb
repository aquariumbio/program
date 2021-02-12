# frozen_string_literal: true

needs 'Standard Libs/Units'
needs 'Program Libs/ProgramStep'


# think about people writing loops in program e.g. go to step 3 and continue etc...

# Factory class for instantiating `ProgramStep`
# @author Devin Strickland <strcklnd@uw.edu>
class ProgramFactory
  # Instantiates `PCRComposition`
  #
  # @param program_name [String] the name of one of the default program hashes
  # @param steps [Array<Steps>]
  def self.build(program:)
    Program.new(program: program)
  end
end

# Models a program.
#
# @param steps [Array<hash>] hash should define the steps
class Program
  include Units

  attr_reader :steps, :program_name

  def initialize(program:)
    @steps = generate_steps(program[:steps])
    @program_name = program[:program_name]
  end

  def next_step
    steps_to_do = @steps.reject(&:completed?)
    steps_to_do.sort(&:step_number).first
  end

  def last_step
    @steps.sort(&:step_number).last
  end

  def first_step
    @steps.sort(&:step_number).first
  end

  def find_step(step_number:)
    @steps.detect{ |step| step.step_number = step_number }.first
  end

  private

  def generate_steps(arry_steps)
    stps = []
    arry_steps.each_with_index do |step, idx|
      stps.push(ProgramStepFactory.build(
                  step_number: idx,
                  action: step[:action],
                  item: step[:item],
                  to_item: step[:to_item],
                  program: step[:program]
                ))
    end
    stps
  end
end
