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
b = a.my_each_with_index
print b.next
print "\n"
c = a.my_each_with_index { |x, y| print "[#{y},#{x}]" }
print "\n"
print c
print "\n"
range = (1...13)
range.my_each_with_index { |x, y| print "[#{y},#{x}]" }
d=a.my_select
print "\n"
print d.next
print d.next