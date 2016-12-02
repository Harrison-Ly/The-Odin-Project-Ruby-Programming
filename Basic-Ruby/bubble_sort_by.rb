def bubble_sort_by(array)
  loop do
    swapped = false
    (array.length-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end
    break if not swapped
  end
  array
end


p bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end
