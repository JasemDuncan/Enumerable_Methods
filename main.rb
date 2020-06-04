# frozen_string_literal: true

module Enumerable
  def my_each
    return enum_for unless block_given?

    arr = self
    if arr.is_a?(Range)
      arr = self.to_a
    end
    count = 0
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

  def my_all?(*args)
    arr = self
    if(args[0])
      arr.my_each do |x|
        return false unless x == args[0]
        return true
      end
    else
      arr.my_each do |x|
        return false unless yield(x)
        return true
      end
    end
  end

  def my_any?(*args)
    arr = self
    if(args[0])
      arr.my_each do |x|
        return true unless x == args[0]
        return false
      end
    else
      arr.my_each do |x|
        return true unless yield(x)
        return false
      end
    end
  end

  def my_none?
    !self.my_any?
  end

  def my_count(*args)
    count = 0;
    if(args[0])
      self.my_each do |x| 
        if x == args[0] 
          count += 1
        end 
      end
    elsif !block_given?
      count = self.size
    elsif(!args[0])
      my_each do|x| 
        if yield x 
          count += 1
        end
      end
    end
    count
  end

  def my_map
    return enum_for unless block_given?

    array = []
    self.my_each do |x|
      array.push yield(x)
    end
    array 
  end

  def my_inject(*args)
    array = self
    if self.is_a?(Range)
      array = self.to_a
    end

    if block_given?
      start = args[0] if args[0].is_a?(Integer)
      array.my_each do |num| 
        if start = start
          start = yield(start, num)
        else
          start = num
        end 
      end
      return start
    end
  end


  # def my_inject(*args)
  #   list = is_a?(Range) ? to_a : self

  #   reduce = args[0] if args[0].is_a?(Integer)
  #   operator = args[0].is_a?(Symbol) ? args[0] : args[1]

  #   if operator
  #     list.my_each { |item| reduce = reduce ? reduce.send(operator, item) : item }
  #     return reduce
  #   end
  #   list.my_each { |item| reduce = reduce ? yield(reduce, item) : item }
  #   reduce
  # end

end
puts "result"
puts (5..10).my_inject(1){ |sum,num| sum + num}         #=> 45
# puts (5..10).inject{ |sum,num| sum + num}         #=> 45
# (5..10).my_each{ |x| puts x}         #=> 45
# puts (5..10).my_inject(1) { |sum, n| sum + n } 
# puts (5..10).my_inject { |product, n| product * n } #=> 151200
# [1,2,3].my_each {|i| print "-#{i}- "}
# [4,3,2].my_each_with_index {|i,index| puts "-index #{index} : #{i}- "}
# print [1, 2, 3, 4, 5].my_all?(&:even?)
# print [1, 3, 5, 9].my_any?(&:even?)
