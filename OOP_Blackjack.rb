# OOP Setup
# Extract major nouns to think about abstracting behaviors into Classes.

#nouns:
#game(start, end)
#cards(suit, value)
#deck(shuffle,deal)
#player(hit,stay,bet)
#dealer(deal,hit,stay)

class Deck(cards)
  
  def initialize(value,suit)
    @value = value
    @suit = suit
    cards = []
  end

  def shuffle
  end
  
  def deal
    cards.pop
  end

end


class Player

  def hit
  end

  def stay
  end

  def bet
  end

end


class Dealer

  def deal
  end

  def hit
  end

  def stay
  end

end

class Game
end


