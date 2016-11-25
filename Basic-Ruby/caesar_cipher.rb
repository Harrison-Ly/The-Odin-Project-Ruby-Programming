def caesar_cipher(string, factor)
  caesar = string.split("")
  letter = []
  factor %= 26

  caesar.each do |c|
    change = c[0] + factor

    if ("a".."z").include?(c)
      change > ?z ? change -= 26 : change
      letter << change.chr
    elsif ("A".."Z").include?(c)
      change > ?Z ? change -= 26 : change
      letter << change.chr
    else
      letter << c
    end
  end
  puts letter.join()
end

caesar_cipher("What a string!", 5)
