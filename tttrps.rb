#1. Have detailed requirements or specifications in written form
#2. Extract major nouns -> classes
#3. Extract major verbs -> instance methods
#4. Group instance methods into classes

#private method `select' called for nil:NilClass, board is nil, check into getter/setter methods

class GameBoard
  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize
    @board = {}
    (1..9).each { |pos| @board[pos] = Square.new(' ') }
  end

  def empty_squares
    @board.select { |_, square| square.empty? }.values
  end

  def empty_positions
    @board.select { |_, square| square.empty? }.keys
  end

  def full_board?
    empty_squares.size == 0
  end

  def three_in_a_row?(marker)
    WINNING_LINES.each do |line| 
    return true if @board[line[0]].value == marker && @board[line[1]].value == marker && @board[line[2]].value == marker
    end
    false
  end

  def mark_square(pos, marker)
    @board[pos].mark(marker)
  end

  def draw_board
    system 'clear'
    puts
    puts "     |     |"
    puts "  #{@board[1]}  |  #{@board[2]}  | #{@board[3]} "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@board[4]}  |  #{@board[5]}  | #{@board[6]} "
    puts "     |     | "
    puts "-----+-----+-----" 
    puts "     |     |"
    puts "  #{@board[7]}  |  #{@board[8]}  | #{@board[9]} "
    puts "     |     |"
    puts
  end
end
  

class Player
  attr_reader :marker, :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end


class Square
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def empty?
    @value == ' '
  end

  def mark(marker)
    @value = marker
  end

  def to_s
    @value
  end
end


class Game

  def initialize
    @board = GameBoard.new
    @human = Player.new("Amanda", "X")
    @computer = Player.new("Alpha900", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts "Choose a position #{@board.empty_positions} to make your move:"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def current_player_wins?
    @board.three_in_a_row?(@current_player.marker)
  end
  
  def play
    @board.draw_board
    loop do
      puts "Let's play Tic-Tac-Toe!"
      current_player_marks_square
      @board.draw_board
      if current_player_wins?
        puts "The winner is #{@current_player.name}!"
        break
      elsif @board.full_board?
        puts "It's a tie!"
        break
      else
        alternate_player
      end
    end
  end
end

Game.new.play