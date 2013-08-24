require 'rubygems'
require 'pry'

class Card
attr_accessor :suit, :value

  def initialize(s,v)
    @suit = s
    @value = v
  end

  def read_it
    puts "The #{value} of #{suit}"
  end

  def to_s
    read_it
  end
end


class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['Hearts', 'Diamonds', 'Spades', 'Clubs'].each do |suit|
      ['2','3','4','5','6','7','8','9','10','J','Q','K','A'].each do |val|
        @cards << Card.new(suit,val)
      end
    end

    shuffle_up!
  end

  def shuffle_up!
    cards.shuffle!
  end

  def deal_it
    cards.pop
  end

end

module Handable

  def show_hand
    puts "====#{name}'s Hand===="
    cards.each do |show|
       "=>#{show}"
    end
    puts "=> Total #{total}"
  end

  
  def total
    value = cards.map{|card| card.value}

    total = 0
    value.each do |val|
      if val == 'A'
        total += 11
      elsif val.to_i == 0
        total += 10
      else 
        total += val.to_i
      end
    end

    value.select{|val| val == 'A'}.count.times do
      break if total <= 21
      total -= 10
    end
    total

  end

  
  def dealt_card(new_card)
    cards << new_card
  end
end




class Dealer
  include Handable

  attr_accessor :name, :cards

  def initialize
    @name = 'Dealer'
    @cards = []
  end

  def show_flop
    puts "====Dealer's Hand===="
    puts "=> First card is #{cards[0].read_it}"
    puts "=> Second card is hidden..."
  end

   def read_it
    "The #{value} of #{suit}"
  end

  def to_s
    read_it
  end

  def dealer_hand
    puts "The Dealer is showing"
    cards.each do |show|
       "=>#{show}"
    end
  end
end


class Player
  include Handable

  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def busto?
    total > 21
  end
end



class Blackjack
  attr_accessor :player, :deck, :dealer
  def initialize
    @player = Player.new('name')
    @deck = Deck.new
    @dealer = Dealer.new
  end



  def name_player
    puts "What is your name?"
    player.name = gets.chomp
  end

  def deal_cards
    player.dealt_card(deck.deal_it)
    dealer.dealt_card(deck.deal_it)
    player.dealt_card(deck.deal_it)
    dealer.dealt_card(deck.deal_it)
  end

  def showtime
    player.show_hand
    dealer.show_flop
  end

  def bj_or_bust?(player_or_dealer)
    if player_or_dealer.total == 21
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack, you lose."
      else
        puts "Congratulations, you hit Blacjack! You win!!"
      end
      new_game?
    elsif player_or_dealer.total > 21
      if player_or_dealer.is_a?(Dealer)
        puts "Congratulations, dealer busted! You win!!"
      else
        puts "Sorry, you busted! You lose"
      end
      new_game?
    end
  end

  def player_turn
    puts "#{player.name}'s turn."

    bj_or_bust?(player)

    while !player.busto?
      puts "What would you like to do? 1) Hit 2) Stay"
      choice = gets.chomp

      if !['1', '2'].include?(choice)
        puts "Error: please choose either 1 or 2"
        next
      end

        if choice == '2'
          puts "#{player.name} has chosen to stay."
          break
        end

        #hit
        new_card = deck.deal_it
        puts "Dealing card to #{player.name}: #{new_card}"
        player.dealt_card(new_card)
        puts "Total is now #{player.total}"

        bj_or_bust?(player)
      end
      puts "#{player.name} stays at #{player.total}"
    end

    def dealer_turn
      puts "Dealer's turn."

      dealer.dealer_hand

      bj_or_bust?(dealer)
      while dealer.total < 17 || dealer.total < player.total
        new_card = deck.deal_it
        puts "Dealing card to dealer: #{new_card}"
        dealer.dealt_card(new_card)
        puts "Dealer total is now: #{dealer.total}"

        bj_or_bust?(dealer)
      end
      puts "Dealer stays at #{dealer.total}."
    end

    def winner?
      if player.total > dealer.total
        puts "Congratulations, You Win!!"
      elsif player.total < dealer.total
        puts "Sorry, You Lose!"
      else
        puts "Game ends in a tie!"
      end
      new_game?
    end

    def new_game?
      puts ''
      puts 'Would you like to play again? 1) Yes 2) No'
      if gets.chomp =='1'
        puts "Starting new game..."
        puts''
        deck = Deck.new
        player.cards = []
        dealer.cards = []
        run
      else
        puts "See ya!"
        exit
      end
    end



  def run
    name_player
    deal_cards
    showtime
    player_turn
    dealer_turn
    winner?
  end

end


game = Blackjack.new
game.run



