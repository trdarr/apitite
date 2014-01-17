require 'parameter'
require 'resource'

class Method
  class << self
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

    # Resource accessors that make the Method DSL useful.
    def name(type=:snake)
      name = self.to_s  # Can't use Class#name because recursion.

      if type == :snake
        name.gsub(/([a-z])([A-Z])/) { |s| "#{$1}_#{$2}" }.downcase
      elsif type == :camel
        name.gsub(/^([A-Z])/) { |s| $1.downcase }
      else
        name
      end
    end

    def verb; resource.method; end
    def method; resource.method; end
    def endpoint; resource.endpoint; end
    def required_params; resource.required_params; end
    def optional_params; resource.optional_params; end

    # Each Method subclass has a Resource as a backing store.
    def resource
      @resource ||= Resource.new
    end

    def set_endpoint(method, endpoint)
      resource.method = method
      resource.endpoint = endpoint

      # If the endpoint has parameter placeholders, `required` them.
      $~.to_a.drop(1).map { |e| required e.to_sym } if /:(\w+)/ =~ endpoint
    end
  end
end
