=begin
1. Have detailed requirements or specifications in written form
2. Extract major nouns -> classes
3. Extract major verbs -> instance methods
4. Group instance methods into classes

dealer deals two cards to themself, and two cards to the player. cards 1-10 are numeric value, face cards equal 10, ace is 1 or 11. the player chooses to either hit or stay, until they are as close to 21 without going over as possible. if they go over 21, the game ends and the dealer wins, if they get 21, the game ends and the player wins. otherwise, the dealer must hit unless their cards equal more than 17, if the dealer hits 21, the game ends and the dealer wins, if it's a tie, it's called a push, if the dealer goes over 21. the player wins. 

player
  -name
dealer
  -name
  - < 17, hit
card
  -to_s
deck
  -create deck
  -give cards value
game
  -hit
  -stay
  -deal
  -compare hands
  -decide winner
    -player
    -dealer
    -push
=end


class Card
  attr_accessor :suit, :value

  def initialize(suit,value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{value} of #{suit}."
  end
end


class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['Hearts', 'Diamonds', 'Spades', 'Clubs'].each do |suit|
      ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand
  def show_hand
    puts "----#{name}'s Hand----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end

  def total
    face_values = cards.map{ |card| card.value }

    total = 0
    face_values.each do |val|
      if val == "Ace"
        total += 11
      else
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end

    face_values.select{ |val| val == "Ace"}.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > 21
  end
end

class Player
  include Hand
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def show_flop
    show_hand
  end
end


class Dealer
  include Hand
  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "---Dealer's Hand---"
    puts "=>First card is hidden"
    puts "Second card is #{cards[1]}"
  end
end


class Blackjack
  attr_accessor :deck, :player, :dealer

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @player = Player.new("Player1")
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def set_player_name
    puts "What's your name?"
    player.name = gets.chomp
  end

  def deal_cards
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.total == BLACKJACK_AMOUNT
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack. #{player.name} loses."
      else
        puts "Congratulations, you hit blackjack! #{player.name} wins!"
      end
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "Congratulations, dealer busted. #{player.name} wins!"
      else
        puts "Sorry, #{player.name} busted. #{player.name} loses."
      end
      play_again?
    end
  end

  def player_turn
    puts "#{player.name}'s turn."

    blackjack_or_bust?(player)

    while !player.is_busted?
      puts "What would you like to do? 1)hit  2)stay"
      response = gets.chomp

      if !['1', '2'].include?(response)
        puts "Error: you must enter 1 or 2"
        next
      end

      if response == '2'
        puts "#{player.name} chose to stay."
        break
      end

      #hit
      new_card = deck.deal_one
      puts "Dealing card to #{player.name}: #{new_card}"
      player.add_card(new_card)
      puts "#{player.name}'s total is now #{player.total}"

      blackjack_or_bust?(player)
    end
    puts "#{player.name} stays at #{player.total}."
  end

  def dealer_turn
    puts "Dealer's turn."

    blackjack_or_bust?(dealer)
    while dealer.total < DEALER_HIT_MIN
      new_card = deck.deal_one
      puts "Dealing card to dealer: #{new_card}"
      dealer.add_card(new_card)
      puts "Dealer total is now #{dealer.total}"

      blackjack_or_bust?(dealer)
    end
    puts "Dealer stays at #{dealer.total}."
  end

  def who_won?
    if player.total > dealer.total
      puts "Conratulations, #{player.name} wins!"
    elsif player.total < dealer.total
      puts "Sorry, #{player.name} loses."
    else
      puts "It's a tie!"
    end
    play_again?
  end

  def play_again?
    puts ""
    puts "Would you like to play again? 1)yes  2)no, exit"
    if gets.chomp == '1'
      puts "Starting new game..."
      puts ""
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start
    else
      puts "Goodbye!"
      exit
    end
  end 

  def start
    set_player_name
    deal_cards
    show_flop
    player_turn
    dealer_turn
    who_won?
  end
end


game = Blackjack.new
game.start