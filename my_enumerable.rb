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

    for index in self
      yield(self, index)
    end
  end
  self
end

[1, 2, 3, 4].my_each { |x| print x  }
