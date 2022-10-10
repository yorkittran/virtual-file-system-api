class GraphQL::ExecutionError < GraphQL::Error
  attr_accessor :error, :record

  def initialize(error)
    @error = error
    @record = error.try(:record)
  end

  def to_h
    if record.present?
      record.errors.first.full_message
    else
      error
    end
  end
end
