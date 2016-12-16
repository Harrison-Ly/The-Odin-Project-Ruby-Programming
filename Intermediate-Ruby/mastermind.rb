module MasterMind
  $colours = %W(R G B Y O P)

  class CodeMaker
    attr_accessor :secret_combo
    def matched(guess)
      guess = guess.split("")
      if guess == @secret_combo
        result
        true
      else
        false
      end
    end

    def result
      puts "You guessed the correct code!"
      puts "You WIN!"
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
      arr = [white_peg, black_peg]
    end

    protected
    def initialize
      @secret_combo = 4.times.map { $colours.sample } #{}%W(B B R G)
    end
  end

  class CodeMakerHuman < CodeMaker
    def initialize(code)
      @secret_combo = code.split("")
    end

    def result
      puts "Computer guessed the correct code!"
      puts "You LOSE!"
    end
  end

  class CodeBreaker
    attr_accessor :guess
    def initialize
      @guess = "asdfasdf"
    end

    def guessing(code_maker=false)
      @guess = gets.chomp.upcase
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

  class CodeBreakerAI < CodeBreaker
    def guessing(code_maker)
      #Stupid AI
      puts @guess = 4.times.map { $colours.sample }.join("")
      black_peg = code_maker.checkpegs(@guess)[1]
    end
  end

  class Game
    def initialize( option = "B" )
      @ended = false
      if option == "B"
        @code_maker = CodeMaker.new
        @code_breaker = CodeBreaker.new
      else
        human_secret_code = ""
        until /^[RGBYOP]{4}$/.match(human_secret_code)
          puts "Enter your secret code: (ex. RGBY)"
          human_secret_code = gets.chomp.upcase
        end
        @code_maker = CodeMakerHuman.new(human_secret_code)
        @code_breaker = CodeBreakerAI.new
      end
      turns
    end

    def turns
      while !@ended
        puts ""
        puts "Enter your guess: [R]ed, [G]reen, [B]lue, [Y]ellow, [O]range, [P]urple"
        @code_breaker.guessing(@code_maker)
        if @code_breaker.valid_guess?
          if @code_maker.matched(@code_breaker.guess)
            @ended = true
            break
          else
            pegs = @code_maker.checkpegs(@code_breaker.guess)
            puts "White Peg #{pegs[0]}, Black Peg #{pegs[1]}"
            @ended = @code_breaker.guessed?
          end
        end

      end
      puts "Answer: #{@code_maker.secret_combo.join()}"
    end
  end

  def start
    intro
    game = Game.new(options)
  end

  def intro
    puts "Welcome to Mastermind!"
    puts "There are 6 colours: [R]ed, [G]reen, [B]lue, [Y]ellow, [O]range, [P]urple"
    puts "The code is a combination of 4."
    puts "You have 12 guesses to break the code."
    puts "Good Luck!"
    puts ""
  end

  def options
    answer = ""
    selection = %W(M B)
    while !(selection.include?(answer))
      puts "Do you want to be a Code[M]aker or Code[B]reaker?"
      answer = gets.chomp.upcase
      if not selection.include?(answer)
        puts "Please enter [M] or [B]"
      end
    end
    answer
  end


end

include MasterMind
start
