module Enumerable
  def my_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    return self unless block_given?
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return self unless block_given?
    selected = []
    self.my_each { |i| selected << i if yield(i) }
    selected
  end

  def my_all?
    return self unless block_given?
    pass = true
    self.my_each do |x|
      if yield(x) == false
        pass = false
      else
        pass = true
      end
    end
    pass
  end

  def my_any?
    return self unless block_given?
    pass = false
    self.my_each do |x|
      if yield(x) == true
        pass = true
        break
      else
        pass = false
      end
    end
    pass
  end

  def my_none?
    if self[0] == nil
      true
    else
      false
    end
  end

  def my_count
    count = 0
    self.my_each { |x| count += 1 }
    count
  end

  def my_map(&proc)
    newList = []
    self.my_each do |x|
      newList << yield(x)
    end
    newList
  end

  def my_inject(&proc)
    return self unless block_given?
    total = 1
    self.my_each do |x|
      total = yield(total, x)
    end
    total
  end
end

def multiply_els(array)
  array.my_inject { |total, i| total * i }
end

squared = Proc.new {|i| i**2}

#Tests
=begin
puts "Test: my_each"
puts [1,2,3].my_each { |i| puts i * 2}

puts "Test: my_each_with_index"
puts [5,2,6].my_each_with_index { |val, index| puts "#{val} #{index}"}

puts "Test: my_select"
puts [1,2,3,4,5,7,8,9].my_select { |i| i == 5}

puts "Test: my_all?"
puts %w[ant bear ca].my_all? { |word| word.length >= 3 }

puts "Test: my_any?"
puts %w[ant bear cat].my_any? { |word| word.length >= 2 }

puts "Test: my_none?"
puts [].my_none?

puts "Test: my_count"
puts [1,2,3,9].my_count

puts "Test: my_map"
puts ["a", "b", "c", "d", "e"].my_map { |x| x + x}.inspect

puts "Test: my_inject"
puts (5..10).inject { |sum, n| sum + n }

puts "Test: multiply_els"
puts multiply_els([2,4,5]).inspect #=> 40

puts "Test: my_map proc test"
puts [5,1,7,4,1,3,9,0].my_map(&squared)
=end
