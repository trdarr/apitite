class Parameter
  def initialize(name, options)
    @name = name

    keys = [:default, :type]
    options.map do |k, v|
      instance_variable_set("@#{k}", v) if keys.include? k
    end
  end

  def name(type=:snake)
    name = @name.to_s
    name.gsub(/([a-z])_([a-z])/) { |s| "#{$1}#{$2.upcase}" } if type == :camel
    name  # snake_case or unspecified.
  end

  def to_s; name; end
  def to_sym; @name; end
end
