require 'rubygems'
require 'pry'

module Hand
  def show_hand
    puts "====#{name}'s Hand===="
    cards.each do |show|
       "=> #{show}"
    end
    puts "=> Total: #{hand_total}"
  end

  def hand_total
    value = cards.map{|card| card.value}

    total = 0
    value.each do |val|
      if val == 'a'.downcase
        total += 11
      else 
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end

    #find and correct for Aces
    value.select{|val| val == 'a'.downcase}.count.times do 
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    @cards << new_card
  end

  def busted?
    hand_total > 21
  end

end


class Card
attr_accessor :suit, :value

  def initialize(s,v)
    @suit = s
    @value = v
  end

  def output
    puts "the #{value} of #{suit_name}"
  end

  def suit_name
    name = case suit
            when 'h'.downcase then 'Hearts'
            when 'd'.downcase then 'Diamonds'
            when 'c'.downcase then 'Clubs'
            when 's'.downcase then 'Spades'
          end
    name
  end

  def to_s
    output
  end

end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['h','d','c','s'].each do |suit|
      ['2','3','4','5','6','7','8','9','10','J','Q','K','A'].each do |value|
        @cards << Card.new(suit,value)
      end
    end
    shuffle_up!
  end

  def shuffle_up!
    @cards.shuffle!
  end

  def deal_card
    cards.pop
  end

  def to_s
    puts "the #{value} of #{suit_name}"
  end

end


class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = 'Dealer'
    @cards = []
  end

  def show_flop
    puts "==== Dealer's Hand===="
    puts "First Card is hidden"
    puts "second card #{cards[1]}"
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


class Blackjack
  attr_accessor :deck, :dealer, :player, :name

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new("Player 1")
  end

  def player_name
    puts "Hello, what is your name?"
    player.name = gets.chomp
    puts "Good Luck #{player.name}!!"
  end

  def deal
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.hand_total == 21
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack. You lose."
      else 
        puts "Congratulations! You hit Blackjack! You Win!!!"
      end
      exit
    elsif player_or_dealer.busted?
      if player_or_dealer.is_a(Dealer)
        puts "Congratulations! Dealer has busted, you win!!!"
      else
        puts "Sorry, you busted! You lose!!"
      end
      exit
    end
  end

  def player_go
    puts "#{player.name}'s turn."

    blackjack_or_bust?(player)

    while !player.busted?
      puts "What would you  like to do? 1) hit 2) stay"
      choice = gets.chomp

      if !['1','2'].include?(choice)
        puts "Error: you must enter either 1 or 2"
        next

        if response == '2'
          puts "#{player.name} is choosing to stay."
          break
        end

        #hit
        new_card = deck.deal_card
        puts "Dealing card to #{player.name}: #{new_card}"
        player.add_card(new_card)
        puts "#{player.name}'s total is now #{player.hand_total}"

        blackjack_or_bust?(player)
      end
      puts "#{player.name} stays."

    end
  end

  def start
    player_name
    deal
    show_flop
    player_go
    #dealer_go
    #who_won?
  end

end

game = Blackjack.new
game.start










































