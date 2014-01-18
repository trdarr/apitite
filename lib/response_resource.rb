class ResponseResource
  attr_reader :fields

  def fields
    @fields ||= []
  end
end
