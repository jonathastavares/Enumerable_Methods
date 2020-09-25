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

  def my_map
    return to_enum(_method_) unless block_given?

    array = []
    my_each { |x| array << yield(x) }
    array
  end

  def my_inject(number = nil, operator = nil)
    if !block_given? && number != nil && operator != nil
      operator = operator.to_s
      operator = ':' + operator
      if operator == ':+'
        result = 0
        my_each { |x| result += x }
        result += number
        result
      elsif operator == ':*'
        result = 1
        my_each { |x| result *= x }
        result *= number
        result
      end
    elsif !block_given? && number != nil && operator == nil
      number = number.to_s
      number = ':' + number
      if number == ':+'
        result = 0
        my_each { |x| result += x }
        result
      elsif number == ':*'
        result = 1
        my_each { |x| result *= x }
        result
      end
    elsif block_given? && number == nil && operator == nil
      if
        result = 0
        my_each { |x| result = yield(result, x) }
        result
      elsif
        result = 1
        my_each { |x| result = yield(result, x) }
        result
      end
    end
  end
end

print [1, 2, 3, 4].my_inject { |sum, n| sum * n }
