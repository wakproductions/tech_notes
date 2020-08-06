# Call the project RubyCodePrettifier... then you can have a class to prettify every kind of object?
#   - RubyCodePrettifier::PrettifyHash
#   - RubyCodePrettifier::PrettifyArray
#   - ...
#
# What's the interface going to be like for custom objects? What inputs and methods are required on a Prettify___ class?

module IndentUtil
  INDENT_SIZE = 2

  def indent_chars(indent_level)
    ' ' * INDENT_SIZE * indent_level
  end
end

class PrettifyObject
  MAX_LINE_SIZE = 120

  def self.call(object, **options)
    new.call(object, **options)
  end

  def call(_object, **options)
    @current_indent = options[:indent] || 0
  end

  private

  attr_reader :current_indent

  # TODO - for class type items, allow passing in of "Prettify_" processing classes for special handling.
  def stringify_value(value, **args)
    case value
    when String
      (value =~ /'/).present? ? %{"#{value}"} : "'#{value}'"
    when BigDecimal
      "#{value}.to_d"
    when Hash
      PrettifyHash.call(value, indent: current_indent + 1, preceding_chars: args[:preceding_chars])
    when Array
      PrettifyArray.call(value, indent: current_indent + 1, preceding_chars: args[:preceding_chars])
    when nil
      'nil'
    else
      value.to_s
    end
  end
end

class PrettifyArray < PrettifyObject
  include IndentUtil

  def call(array, indent: 0, preceding_chars: '', force_wrap: false)
    super
    return stringify_array_as_wrapped_lines(array, indent) if force_wrap

    as_one_line = stringify_array_as_one_line(array)
    if string_too_long?(preceding_chars + as_one_line)
      stringify_array_as_wrapped_lines(array, indent)
    else
      as_one_line
    end
  end

  private

  def stringify_array_as_one_line(array)
    string_values =
      array.map do |v|
        stringify_array_value(v)
      end
        .join(', ')

    "[#{string_values}]"
  end

  def stringify_array_value(value, indent_chars='')
    preceding_chars = "#{indent_chars}"
    "#{preceding_chars}#{stringify_value(value, preceding_chars: preceding_chars).strip}"
  end

  def stringify_array_as_wrapped_lines(array, indent)
    base_indent = indent_chars(indent)
    additional_indent = indent_chars(indent + 1)

    string_values =
      array.map do |v|
        stringify_array_value(v, additional_indent)
      end
        .join(",\n")

    "#{base_indent}[\n" \
    "#{string_values}\n" \
    "#{base_indent}]"
  end

  def string_too_long?(string)
    string.size > MAX_LINE_SIZE
  end

end

class PrettifyHash < PrettifyObject
  include IndentUtil

  def call(hash, indent: 0, preceding_chars: '', force_wrap: false)
    super
    return stringify_hash_as_wrapped_lines(hash, indent) if force_wrap

    as_one_line = stringify_hash_as_one_line(hash)
    if string_too_long?(preceding_chars + as_one_line)
      stringify_hash_as_wrapped_lines(hash, indent)
    else
      as_one_line
    end
  end

  private

  def stringify_hash_as_one_line(hash)
    string_values =
      hash.map do |k, v|
        stringify_hash_key_value_pair(k, v)
      end
          .join(', ')

    "{ #{string_values} }"
  end

  def stringify_hash_key_value_pair(key, value, indent_chars='')
    preceding_chars = "#{indent_chars}#{key}: "
    "#{indent_chars}#{key}: #{stringify_value(value, preceding_chars: preceding_chars).strip}"
  end

  def stringify_hash_as_wrapped_lines(hash, indent)
    base_indent = indent_chars(indent)
    additional_indent = indent_chars(indent + 1)

    string_values =
      hash.map do |k, v|
        stringify_hash_key_value_pair(k, v, additional_indent)
      end
          .join(",\n")

    "#{base_indent}{\n" \
    "#{string_values}\n" \
    "#{base_indent}}"
  end

  def string_too_long?(string)
    string.size > MAX_LINE_SIZE
  end
end
