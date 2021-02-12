# frozen_string_literal: true
needs 'Standard Libs/Units'

# Factory class for instantiating `ProgramStep`
# @author Devin Strickland <strcklnd@uw.edu>
class ProgramStepFactory
  # Instantiates `PCRComposition`
  #
  # @return [PCRProgram]
  def self.build(step_number:, action:, item:, to_item: nil, status: false, program: nil)
    ProgramStep.new(step_number: step_number, action: action, item: item, to_item: to_item, program: program, status: status)
  end
end

# Models a step in a program.   Very basic shouldn't do much (might should just be a hash)
#
class ProgramStep
  include Units

  attr_reader :step_number, :action, :item, :status, :to_item, :program

  def initialize(step_number:, action:, item:, to_item:, status: false, program:)
    @step_number = step_number
    @action = action
    @item = item
    @to_item = to_item
    @status = status
    @program = program
    @to_item = to_item
  end

  def completed?
    @status
  end

  def complete
    @status = true
  end
end
