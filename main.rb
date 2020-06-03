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
      yield arr[count],count
      count += 1      
    end
  end 
end

# [1,2,3].my_each {|i| print "-#{i}- "}
[4,3,2].my_each_with_index {|i,index| puts "-index #{index} : #{i}- "}

