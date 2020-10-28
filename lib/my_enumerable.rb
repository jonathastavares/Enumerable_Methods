# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum(__method__) unless block_given?

    array = to_a
    i = 0
    until i == array.length
      yield(array[i])
      i += 1
    end
    if array.is_a?(Numeric) && Range.new(array.first, array.last) == self
      self
    else
      array
    end
  end

  def my_each_with_index
    return to_enum(__method__) unless block_given?

    array = to_a
    i = 0
    until i == array.length
      yield(array[i], i)
      i += 1
    end
    if Range.new(array.first, array.last) == self
      self
    else
      array
    end
  end

  def my_select
    return to_enum(__method__) unless block_given?

    array = []
    my_each { |x| array << x if yield(x) }
    array
  end

  def my_all?(*type)
    origin = to_a
    return true if origin == []

    if !block_given? && type.length.zero?
      return false if origin.include?(false) || origin.include?(nil)

      return true
    end

    if type.length == 1
      checker = origin.my_select { |x| x =~ type[0] } if type[0].instance_of?(Regexp)
      checker = origin.my_select { |x| x.is_a?(type[0]) } if type[0].is_a?(Class)
      checker = origin.my_select { |x| x == type[0] } unless type[0].instance_of?(Regexp) || type[0].is_a?(Class)

      checker.length < origin.length ? (return false) : (return true)
    end

    checker = my_select { |x| yield(x) } if block_given? && type.length.zero?
    checker.length < origin.length ? (return false) : (return true)
  end

  def my_any?(*type)
    origin = to_a
    return false if origin == []

    if !block_given? and type.length.zero?
      each { |x| return true if !x.nil? and x != false }
      return false
    end

    if type.length == 1
      checker = origin.my_select { |x| x =~ type[0] } if type[0].instance_of?(Regexp)
      checker = origin.my_select { |x| x.is_a?(type[0]) } if type[0].is_a?(Class)
      checker = origin.my_select { |x| x == type[0] } unless type[0].instance_of?(Regexp) || type[0].is_a?(Class)
      checker.empty? ? (return false) : (return true)
    end

    return true unless all? { |x| !yield(x) }

    false
  end

  def my_none?(*type)
    origin = to_a
    return true if origin == []

    if !block_given? and type.length.zero?
      return true if origin.my_all? { |x| x.nil? || x == false }

      return false
    end

    if type.length == 1
      checker = origin.my_select { |x| x =~ type[0] } if type[0].instance_of?(Regexp)
      checker = origin.my_select { |x| x.is_a?(type[0]) } if type[0].is_a?(Class)
      checker = origin.my_select { |x| x == type[0] } unless type[0].instance_of?(Regexp) || type[0].is_a?(Class)
      checker.empty? ? (return true) : (return false)
    end

    !my_any? { |x| yield(x) }
  end

  def my_count(argument = nil)
    origin = to_a

    return origin.length if !block_given? and !argument

    if argument
      count = origin.my_select { |x| x == argument }
      return count.length

    elsif block_given?
      count = origin.my_select { |x| yield(x) }
      return count.length
    end

    length
  end

  def my_map(my_proc = nil)
    return to_enum(__method__) unless block_given?

    origin = to_a
    array = []
    if my_proc
      origin.my_each { |x| array << my_proc.call(x) }
      return array
    else
      origin.my_each { |x| array << yield(x) }
    end
    array
  end

  def my_inject(*arg)
    origin = to_a
    if !block_given? && arg.length == 1 && origin != [] && arg[0].is_a?(Symbol)
      number = origin[0]
      origin.my_each_with_index do |item, i|
        number = number.send(arg[0], item) if i.positive?
      end
      return number
    end

    if !block_given? && arg.length == 2 && origin != []
      number = arg[0]
      origin.my_each do |item|
        number = number.send(arg[1], item)
      end
      return number
    end

    yield 1 unless block_given?

    if block_given? && arg.length == 1 && origin != []
      number = arg[0]
      origin.my_each do |item|
        number = yield(number, item)
      end
      return number
    end

    if block_given? && arg.length.zero? && origin != []
      number = origin[0]
      origin.my_each_with_index do |item, i|
        number = yield(number, item) if i.positive?
      end
    end
    number
  end
end

def multiply_els(array)
  array.my_inject { |result, item| result * item }
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength
