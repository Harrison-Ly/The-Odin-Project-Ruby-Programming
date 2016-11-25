def substrings(strings, dictionary)
  list = Hash.new(0)

  strings = strings.split(" ")

  strings.each do |string|
    dictionary.each do |word|
      if string.downcase.include?(word)
        list[word] +=1
      end
    end
  end
  puts list.sort.to_h
end



#test
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary) #answer {"below"=>1, "low"=>1}

#test 2
substrings("Howdy partner, sit down! How's it going?", dictionary)
#answer {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
