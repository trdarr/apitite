require 'method_resource'
require 'named'
require 'parameter'

class Method
  class << self
    include Named

    # Resource mutators that define the Method DSL.
    def get(endpoint)
      set_endpoint :get, endpoint
    end

    def post(endpoint)
      set_endpoint :post, endpoint
    end

    def required(name, options={})
      parameter = Parameter.new name, options
      resource.required_params << parameter
    end

    def optional(name=nil, options={})
      name ||= :options
      parameter = Parameter.new name, options
      resource.optional_params << parameter
    end

    def returns(type)
      resource.return_type = type
    end

    # Resource accessors that make the Method DSL useful.
    def verb; resource.method; end
    def method; resource.method; end
    def endpoint; resource.endpoint; end
    def required_params; resource.required_params; end
    def optional_params; resource.optional_params; end
    def return_type; resource.return_type; end

    # Each Method subclass has a Resource as a backing store.
    def resource
      @resource ||= MethodResource.new
    end

    def set_endpoint(method, endpoint)
      resource.method = method
      resource.endpoint = endpoint

      # If the endpoint has parameter placeholders, `required` them.
      $~.to_a.drop(1).map { |e| required e.to_sym } if /:(\w+)/ =~ endpoint
    end
  end
end
