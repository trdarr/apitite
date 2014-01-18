module Named
  def name(type=nil)
    name = self.to_s  # Can't use Class#name because recursion.

    case type
    when :snake
      name.gsub(/([a-z])([A-Z])/) { |s| "#{$1}_#{$2}" }.downcase
    when :camel
      name.gsub(/^([A-Z])/) { |s| $1.downcase }
    else
      name
    end
  end
end
