module ErrorHandler
  def format_activerecord_errors(errors)
    result = []
    errors.each do |attribute, error|
      result << { attribute => error }
    end
    result
  end
end