class MethodResource
  attr_accessor :method, :endpoint, :return_type
  attr_reader :required_params, :optional_params

  def required_params
    @required_params ||= []
  end

  def optional_params
    @optional_params ||= []
  end
end
