# I struggled for days to bring you this lovely Blackjack game, enjoy!
# updated with proper indentation

puts "Welcome to Blackjack!"
puts "What is your name?"
name = gets.chomp

puts "Good luck #{name}!"
puts""
puts "Shuffling....................."
puts""

cards = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
suits = ['c','h','s','d']

deck = cards.product(suits)

#shuffle deck
deck.shuffle!

my_cards =[]
dealer_cards = []

#deal cards
my_cards << deck.pop
dealer_cards << deck.pop
my_cards << deck.pop


dealer_total = 0
my_total = 0


def card_count(hand)
	single_card = hand.map{|h| h[0] }

	card_total = 0
	single_card.each do |sum|
		if sum == "A"
			card_total += 11
		elsif sum.to_i == 0
			card_total += 10
		else
			card_total += sum.to_i
		end
	end

	#Find Aces

	single_card.select{|e| e =="A"}.count.times do
		card_total -= 10 if card_total > 21
	end

	card_total
end



my_total += card_count(my_cards)
dealer_total += card_count(dealer_cards)


puts "You have been dealt #{my_cards} for a total of #{my_total}"
puts ""

puts "Dealer is showing #{dealer_cards} for a total of #{dealer_total}"
puts ""


def ask
	puts "What would you like to do? 1)Hit 2)Stay"
end

if my_total == 21
	puts "You hit Blackjack! You Win!!"
else
	#hit
	my_total = my_total.to_i
	while  my_total < 21
		ask
		hit_or_stay = gets.chomp

		if hit_or_stay == "1"
			new_card = deck.pop
			my_cards << new_card
			my_total = card_count(my_cards)
			puts "dealing..."
			puts "You drew #{new_card} and now have #{my_cards} for a total of #{my_total}"
		else 
			hit_or_stay == "2"
			puts "You have chosen to stay and have #{my_cards} for a total of #{my_total}"
			break
		end
	end

	if my_total > 21
		puts "You Busted! Dealer Wins"
	else
		puts ""
		puts "Dealer will now draw..."
		new_dealer = deck.pop
		dealer_cards << new_dealer
		dealer_total = card_count(dealer_cards)
		puts "Dealer is showing #{dealer_cards} for a total of #{dealer_total}"


		while dealer_total < 21
			puts "Dealer will now draw..."
			new_dealer = deck.pop
			dealer_cards << new_dealer
			dealer_total = card_count(dealer_cards)
			puts "Dealer has drawn #{new_dealer} and has a total of #{dealer_total}"
			puts ""
			if dealer_total <= 18 && dealer_total > my_total
				puts "Dealer is showing #{dealer_cards} for a total of #{dealer_total}"
				break
			elsif dealer_total > my_total && dealer_total <= 21
				puts "Dealer is showing #{dealer_cards} for a total of #{dealer_total}"
				break
			end

			if dealer_total > 21
				puts "The Dealer has busted! You Win!!"
			end
		end
	end
end

if my_total > dealer_total && my_total <= 21 || dealer_total > 21
	puts "Congratulations, You Win!"
else 
	puts "You Lose, better luck next time"
end
























































