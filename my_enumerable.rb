module Enumerable
  def my_each
    return to_enum(_method_) unless block_given?

    i = 0
    until i == length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum(_method_) unless block_given?

    i = 0
    until i == length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum(_method_) unless block_given?

    array = []
    my_each { |x| array << x if yield(x) }
    array
  end

  def my_all?
    return to_enum(_method_) unless block_given?

    array = my_select { |x| !yield(x) }
    array.empty?
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
    if !number.nil? && operator.nil?
      operator = number
      number = nil
    elsif !block_given? && !operator.nil?
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
