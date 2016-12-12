class Player
  attr_reader :name, :number

  @@count = 0

  def initialize(name)
    @name = name
    @number = @@count
    @@count += 1
    puts "Welcome to Tick-Tack-Toe! #{@name}!"
  end

  def win
    puts "#{@name} WINS!"
  end

  def tie
    puts "IT'S A TIE!"
  end
end

class GameBoard
  def initialize
    #empty board
    @board = {}
    (1..9).each { |x| @board[x] = x}

    @finished = false

    #Get the player names + instantise the players
    puts "Enter Player 1 name:"
    @player_one = Player.new(gets.chomp)
    puts "Enter Player 2 name:"
    @player_two = Player.new(gets.chomp)

    @players = [@player_one, @player_two]

    start_game
  end

  def start_game
    i = 0
    while not @finished
      display
      turn(@players[i%2])
      i += 1
    end
    end_game
  end

  def end_game
    display
  end

  def turn(player)
    current_move = 0
    while !(current_move == @board[current_move])
      puts "#{player.name}'s turn: (select your move)"
      current_move = gets.chomp.to_i
      if !(current_move == @board[current_move])
        puts "Please choose a different move!"
      end
    end
    marker = player.number == 0 ? "X" : "O"
    @board[current_move] = marker

    if tie?
      player.tie
      @finished = true
    end

    if win?(marker)
      player.win
      @finished = true
    end
  end

  def tie?
    if !@board.values.any? { |x| x.is_a? Integer }
      true
    else
      false
    end
  end

  def win?(marker)
    result = false
    win_combos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    win_combos.each do |combo|
      win_test = []
      combo.each do |unit|
        win_test << @board[unit]
      end
      if win_test.all? { |x| x == marker }
        result = true
      end
    end
    result
  end

  def display
    puts %Q(
           |     |
        #{@board[1]}  |  #{@board[2]}  |  #{@board[3]}
      _____|_____|_____
           |     |
        #{@board[4]}  |  #{@board[5]}  |  #{@board[6]}
      _____|_____|_____
           |     |
        #{@board[7]}  |  #{@board[8]}  |  #{@board[9]}
           |     |
      )
  end
end

game = GameBoard.new
