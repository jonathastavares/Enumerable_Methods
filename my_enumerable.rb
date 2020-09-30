module Enumerable
  def my_each
    return to_enum unless block_given?

    array = to_a
    i = 0
    until i == array.length
      yield(array[i])
      i += 1
    end
    array
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
end

a = [1, 2, 3, 4, 5]
a = a.my_each
print a.next
print "\n"
b = a.my_each { |x| print x }
print "\n"
print b
