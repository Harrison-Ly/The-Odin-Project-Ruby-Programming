def bubble_sort_by(array)
  loop do
    swapped = false
    (array.length-1).times do |i|
      if yield(array[i], array[i+1]) > 0
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end
    break if not swapped
  end
  array
end


a = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end

p a
