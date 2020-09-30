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

  def my_all?(type = nil)
    origin = to_a

    return true if origin.empty?

    return false if origin.include?(false) || origin.include?(nil)

    return true unless block_given?

    array = my_select { |x| yield(x) }
    return false if array.length < origin.length

    checker = origin.my_select { |x| x == type.to_s[7] } if type.to_s.include? '?-mix'

    checker = origin.my_select { |x| x.instance_of? type }

    return false if checker.length != origin.length

    true
  end

  def my_any?
    return to_enum(_method_) unless block_given?

    !my_all? { |x| !yield(x) }
  end

  def my_none?
    return to_enum(_method_) unless block_given?

    !my_any? { |x| yield(x) }
  end

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

array = [1, 2, 3, 4, 5]
print array.each
print "\n"
print array.each_with_index
print "\n"
print array.select
print "\n"
print array.all?(String)
print "\n"
print "\n"
print "\n"
print array.my_each
print "\n"
print array.my_each_with_index
print "\n"
print array.my_select
print "\n"
print array.my_all?(String)
