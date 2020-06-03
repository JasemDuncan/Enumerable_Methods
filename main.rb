# frozen_string_literal: true

module Enumerable
  def my_each
    return enum_for unless block_given?

    count = 0
    arr = self
    while count < arr.size
      yield arr[count]
      count += 1
    end
  end

  def my_each_with_index
    return enum_for unless block_given?

    count = 0
    arr = self
    while count < arr.size
      yield arr[count], count
      count += 1
    end
  end

  def my_select
    return enum_for unless block_given? # if !block_given? return enum_for

    array_with_selection = []
    my_each do |x|
      array_with_selection.push(x) if yield(x)
    end
    array_with_selection
  end

  def my_all?
    return unless block_given?

    arr = self
    arr.my_each do |x|
      return false unless yield(x)

      return true
    end
  end

  def my_any?
    return unless block_given?

    arr = self
    arr.my_each do |x|
      return true unless yield(x)

      return false
    end
  end

  def my_none?
    return unless block_given?

    !my_any?
  end
end

# [1,2,3].my_each {|i| print "-#{i}- "}
# [4,3,2].my_each_with_index {|i,index| puts "-index #{index} : #{i}- "}
# print [1, 2, 3, 4, 5].my_all?(&:even?)
# print [1, 3, 5, 9].my_any?(&:even?)
