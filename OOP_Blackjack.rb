# OOP Setup
# Extract major nouns to think about abstracting behaviors into Classes.

#nouns:
#game(start, end)
#cards(suit, value)
#deck(shuffle,deal)
#player(hit,stay,bet)
#dealer(deal,hit,stay)

class Card
	def initialize(value,suit)
		@value = value
		@suit = suit
	end
end

class Deck(cards)

	def shuffle
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


