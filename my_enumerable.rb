module Enumerable
  def my_each
    return to_enum(_method_) unless block_given?

    for item in self
      yield(item)
    end
    self
  end
end

[1, 2, 3, 4].my_each{ |x| print x }
