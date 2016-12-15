module MasterMind
  $colours = %W(R G B Y O P)

  class CodeMaker
    attr_accessor :secret_combo
    def matched(guess)
      guess = guess.split("")
      if guess == @secret_combo
        puts "You guessed the correct code!"
        puts "You WIN!"
        true
      else
        checkpegs(guess)
      end
    end

    def checkpegs(guess)
      white_peg = 0
      black_peg = 0
      tmp_combo = @secret_combo.dup

      4.times do |i|
        if guess[i] == tmp_combo[i]
          black_peg += 1
          tmp_combo[i] = ""
        else
          if tmp_combo.include?(guess[i])
            white_peg += 1
            tmp_combo[tmp_combo.index(guess[i])] = ""
          end
        end
      end
      puts "White Peg #{white_peg}, Black Peg #{black_peg}"
    end

    protected
    def initialize
      @secret_combo = %W(B B R G)#4.times.map { $colours.sample }
    end
  end

  class CodeBreaker
    attr_accessor :guess
    def initialize
      @guess = "asdfasdf"
    end

    def guessed?
      @guess_number -= 1
      if @guess_number < 1
        puts "You have no more guesses"
        puts "GAME OVER!"
        true
      else
        puts "You have #{@guess_number} more guesses"
        false
      end
    end

    def valid_guess?
      if /^[RGBYOP]{4}$/.match(@guess)
        true
      else
        if @guess != ""
          puts "Not a valid guess."
        end
        false
      end
    end

    protected
    def initialize
      @guess_number = 12
    end
  end

  class Game
    def initialize
      @code_maker = CodeMaker.new
      @code_breaker = CodeBreaker.new
      @ended = false

      turns
    end

    def turns
      while !@ended
        puts ""
        puts "Enter your guess: [R]ed, [G]reen, [B]lue, [Y]ellow, [O]range, [P]urple"
        @code_breaker.guess = gets.chomp.upcase
        while @code_breaker.valid_guess?
          if @code_maker.matched(@code_breaker.guess)
            @ended = true
            break
          else
            @ended = @code_breaker.guessed?
            @code_breaker.guess = ""
          end
        end

      end
      puts "Answer: #{@code_maker.secret_combo.join()}"
    end
  end

  def start
    intro
    game = Game.new
  end

  def intro
    puts "Welcome to Mastermind!"
    puts "There are 6 colours: [R]ed, [G]reen, [B]lue, [Y]ellow, [O]range, [P]urple"
    puts "The code is a combination of 4."
    puts "You have 12 guesses to break the code."
    puts "Good Luck!"
    puts ""
  end
end

include MasterMind
start
