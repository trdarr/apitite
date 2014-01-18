require 'named'
require 'response_resource'

class Response
  class << self
    include Named

    def field(name)
      resource.fields << name
    end

    def fields
      resource.fields
    end

    def resource
      @resource ||= ResponseResource.new
    end
  end
end
