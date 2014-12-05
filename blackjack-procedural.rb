require 'pry'

def deal_random_card(suited_cards, player_cards)
  suited_cards.each_pair do |k, v|
    v.sample
    k.sample
    player_cards.push(v.sample)
  end
end

card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'king', 'queen', 'jack', 'ace']
card_suits = ['hearts', 'diamonds', 'clubs', 'spades']

suited_cards = {
    card_suits => card_values
}

puts "Would you like to play Blackjack? (y, n)"
user_decision = gets.chomp

player_cards = []

if user_decision.downcase == 'y'
  2.times{deal_random_card(suited_cards, player_cards)}
  puts player_cards
  begin
    puts 'Hit or Stay?'
    hit_or_stay = gets.chomp
    if hit_or_stay.downcase == 'hit'
      deal_random_card(suited_cards, player_cards)

      # TRYING TO SWITCH THE STRINGS IN 'suited_cards' TO THE INTEGER 10
      # player_cards.each do |val|
      #   if val.instance_of?(String)
      #     val == 10
      #   end
      # end
      puts player_cards
      binding.pry
    end
  end until hit_or_stay.downcase == 'stay'
end

###################################################################################################

###################################################################################################

def check_for_winner(player_sum, dealer_sum)
  if player_sum == 21 && dealer_sum < 21
     "You win!"
  elsif player_sum == 21 && dealer_sum == 21
     "It's a tie!"
  elsif player_sum < 21 && dealer_sum == 21
     "The dealer won..."
  end
end

###################################################################################################

###################################################################################################

def dealer_hit_or_stay(dealer_sum)
  if dealer_sum < 17
    dealer_hits
  else
    dealer_stays
  end
end

###################################################################################################
