$: << './lib'
require 'set'

class Python
  def self.method_def(method)
    name = method.name
    parameter_list = method.required_params.map { |e| ", #{e}" }
    parameter_list << ', **kwargs' if method.optional_params
    "def #{name}(self#{parameter_list.join}):"
  end
end

def methods
  old_symbols = Object.constants.to_set
  require_relative 'methods'
  symbols = Object.constants.to_set.difference old_symbols
  symbols.map { |e| Object.const_get e }
         .keep_if { |e| e.ancestors.include? Method }
end

methods.each do |method|
  puts Python.method_def method
end
