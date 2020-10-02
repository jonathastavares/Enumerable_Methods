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
    array
  end

  def my_each_with_index
    return to_enum(__method__) unless block_given?

    array = to_a
    i = 0
    until i == array.length
      yield(array[i], i)
      i += 1
    end
    array
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
      checker = origin.my_select { |x| x.is_a?(type[0]) } unless type[0].instance_of?(Regexp)

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
      checker = origin.my_select { |x| x.is_a?(type[0]) } unless type[0].instance_of?(Regexp)
      checker.empty? ? (return false) : (return true)
    end

    return true unless all?(*type) { |x| !yield(x) }

    false
  end

  def my_none?(*type)
    origin = to_a
    return true if origin == []

    if !block_given? and type.length.zero?
      return true if origin.include?(nil) || origin.include?(false)

      return false
    end

    if type.length == 1
      checker = origin.my_select { |x| x =~ type[0] } if type[0].instance_of?(Regexp)
      checker = origin.my_select { |x| x.is_a?(type[0]) } unless type[0].instance_of?(Regexp)
      checker.empty? ? (return true) : (return false)
    end

    my_any?(*type) { |x| !yield(x) }
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength

  def my_count(argument = nil)
    if argument
      count = my_select { |x| x == argument }
      return count.length

    elsif block_given?
      count = my_select { |x| yield(x) }
      return count.length
    end

    length
  end

  def my_map(proc = nil)
    return to_enum(_method_) unless block_given?

    array = []
    if proc
      my_each { |x| array << procedure.call(x) }
    else
      my_each { |x| array << yield(x) }
    end
    array
  end

  def my_inject(number = nil, operator = nil)
    if !number.nil?
      operator = number
      number = nil
      to_a.my_each { |item| number = number.nil? ? item : number.send(operator, item) }
    elsif !operator.nil?
      to_a.my_each { |item| number = number.nil? ? item : number.send(operator, item) }
    else
      to_a.my_each { |item| number = number.nil? ? item : yield(number, item) }
    end
    number
  end

  def multiply_els(array)
    array.my_inject { |result, item| result * item }
  end
end
