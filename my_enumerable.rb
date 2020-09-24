module Enumerable
  def my_each
    return to_enum(_method_) unless block_given?

    for item in self
      yield(item)
    end
    self
  end

  def my_each_with_index
    return to_enum(_method_) unless block_given?

    for index in self
      yield(self, index)
    end
  end
  self
end

[1, 2, 3, 4].my_each_with_index { |x, y| print y }
