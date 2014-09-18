#1. Have detailed requirements or specifications in written form
#2. Extract major nouns -> classes
#3. Extract major verbs -> instance methods
#4. Group instance methods into classes

#noun
class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(other_hand)
    if @value == other_hand.value
      0
    elsif (@value == 'paper' && other_hand.value == 'rock') || (@value == 'rock' && other_hand.value == 'scissors') || (@value == 'scissors' && other_hand.value == 'paper')
      1
    else
      -1
    end
  end

  def winning_message
    case @value
    when 'paper'
      puts 'Paper covers rock!'
    when 'rock'
      puts 'Rock smashes scissors!'
    when 'scissors'
      puts 'Scissors cuts paper!'
    end
  end  
end

#noun
class Player
  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} has chosen #{self.hand}!"
  end
end

#noun
class Human < Player
  def pick_hand
    begin
      puts "Choose your weapon: rock, paper, or scissors"
      c = gets.chomp.downcase
    end until Rps::CHOICES.keys.include?(c)

    self.hand = Hand.new(c)
  end
end

#noun
class Computer < Player
  def pick_hand
    self.hand = Hand.new(Rps::CHOICES.keys.sample)
  end
end

#noun
class Rps
  CHOICES = {'rock' => 'Rock', 'paper' => 'Paper', 'scissors' => 'Scissors'}

  attr_reader :player, :computer

  def initialize
    @player = Human.new("Amanda")
    @computer = Computer.new("Alpha 900")
  end

  def compare_hands
    if player.hand == computer.hand
      puts "It appears to be a tie!"
    elsif player.hand > computer.hand
      player.hand.winning_message
      puts "#{player.name} wins!"
    else
      computer.hand.winning_message
      puts "#{computer.name} wins. Sorry about your luck!"
    end
  end

  def run
    loop do
      puts "Let's play Rock, Paper, Scissors!"
      player.pick_hand
      computer.pick_hand
      compare_hands
      
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
        if answer == 'y'
          redo
        else
          puts "See ya!"
          break
        end
    end
  end
end

#run game
Rps.new.run