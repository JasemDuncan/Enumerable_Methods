# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    return enum_for unless block_given?

    arr = self
    arr = to_a if arr.is_a?(Range)
    count = 0
    while count < arr.size
      yield arr[count]
      count += 1
    end
    arr
  end

  def my_each_with_index
    return enum_for unless block_given?

    count = 0
    arr = self
    while count < arr.size
      yield arr[count], count
      count += 1
    end
    arr
  end

  def my_select
    return enum_for unless block_given?

    array_with_selection = []
    my_each do |x|
      array_with_selection.push(x) if yield(x)
    end
    array_with_selection
  end

  def my_all?(*args)
    arr = self
    is_all = true
    if !args[0].nil?
      arr.my_each do |x|
        is_all = false unless args[0] == x
      end
    elsif block_given?
      arr.my_each do |x|
        is_all = false unless yield(x)
      end
    else
      arr.my_each do |x|
        is_all = false if x.nil?
      end
    end
    is_all
  end

  def my_any?(*args)
    arr = self
    is_any = false
    if !args[0].nil?
      arr.my_each do |x|
        is_any = true if args[0] == x
      end
    elsif block_given?
      arr.my_each do |x|
        is_any = true if yield(x)
      end
    else
      arr.my_each do |x|
        is_any = true unless x.nil?
      end
    end
    is_any
  end

  def my_none?(*args)
    arr = self
    is_any = false
    if !args[0].nil?
      arr.my_each do |x|
        is_any = true if args[0] == x
      end
    elsif block_given?
      arr.my_each do |x|
        is_any = true if yield(x)
      end
    else
      arr.my_each do |x|
        is_any = true if x
      end
    end
    !is_any
  end

  def my_count(*args)
    count = 0
    if args[0]
      my_each do |x|
        count += 1 if x == args[0]
      end
    elsif !block_given?
      count = size
    elsif !args[0]
      my_each do |x|
        count += 1 if yield x
      end
    end
    count
  end

  def my_map(my_proc = nil)
    return enum_for unless block_given?

    using_proc = !my_proc.nil?
    array = []
    my_each do |x|
      if using_proc
        array.push my_proc.call(x)
      else
        array.push yield(x)
      end
    end
    array
  end

  def my_inject(*args)
    return unless block_given?

    array = self
    array = to_a if is_a?(Range)
    start = args[0] if args[0].is_a?(Integer)
    array.my_each do |num|
      start = if start
                yield(start, num)
              else
                num
              end
    end
    start
  end
end
# rubocop:enable Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end
