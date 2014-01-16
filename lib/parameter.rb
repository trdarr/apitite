class Parameter
  def initialize(name, options)
    @name = name.to_s

    keys = [:default, :type]
    options.map do |k, v|
      instance_variable_set("@#{k}", v) if keys.include? k
    end
  end

  def name(type = :snake)
    if type == :camel
      @name.gsub(/([a-z])_([a-z])/) { |s| "#{$1}#{$2.upcase}" }
    else
      @name
    end
  end

  def to_s; name; end
end
