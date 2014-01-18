$: << './lib'
require 'set'
require_relative 'responses'

class Python
  def self.method_def(method)
    param_list = method.required_params.map { |e| ", #{e.name}" }

    optional = method.optional_params
    params, kwargs = optional.partition { |e| e.to_sym != :options }
    param_list << params.map { |e| ", #{e.name}=None" }
    param_list << ', **kwargs' unless kwargs.empty?

    "def #{method.name :snake}(self#{param_list.join}):"
  end

  def self.method_body(method)
    lines = ["uri = '/'.join((self.base_url, #{method.endpoint}))"]
    params = method.required_params.map { |e| "'#{e.name}': #{e.name}," }
    params[-1][-1] = '}'  # Trailing tail is an embrace on the last arg.

    # Required parameters.
    lines << ('params = {' << params.first)
    lines.concat params.drop(1).map { |e| ' ' * 'params = {'.size << e }

    # Optional parameters.
    optional = method.optional_params
    params, kwargs = optional.partition { |e| e.to_sym != :options }
    params.each do |e|
      lines << "if #{e.name}:" << "    params['#{e.name}'] = #{e.name}"
    end

    # Keyword arguments (kwargs).
    lines << "params.update(kwargs)" unless kwargs.empty?

    verb = method.verb
    lines << "result = self._request(uri, '#{method.verb.to_s.upcase}', params)"
    lines << "return #{method.return_type.name}(result)" if method.return_type

    lines.map { |e| ' ' * 4 << e } << "\n"
  end
end

def get(file_name, ancestor)
  old_symbols = Object.constants.to_set
  require_relative file_name
  symbols = Object.constants.to_set.difference old_symbols
  symbols.map { |e| Object.const_get e }
         .keep_if { |e| e.ancestors.include? ancestor }

end

def methods; get 'methods', Method; end
def responses; get 'responses', Responses; end

methods.each do |method|
  puts Python.method_def method
  puts Python.method_body method
end
