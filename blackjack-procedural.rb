###################################################################################################
player_cards = []
dealer_cards = []

player_card_total = ""
dealer_card_total = 0

dealer_hits = false
dealer_stays = false

###################################################################################################

###################################################################################################
# PICKS A RANDOM 'FACE' AND 'SUIT' - HOW TO REMOVE EACH CARD AFTER IT IS USED?
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'king', 'queen', 'jack', 'ace']
card_suits = ['hearts', 'diamonds', 'clubs', 'spades']

suited_cards = {
    card_suits => card_values,
}

suited_cards.each_pair do |k, v|
  puts "#{v.sample} of #{k.sample}"
end

###################################################################################################

###################################################################################################

def check_for_winner(player_sum, dealer_sum)
  if player_sum == 21 && dealer_sum < 21
    return "You win!"
  elsif player_sum == 21 && dealer_sum == 21
    return "It's a tie!"
  elsif player_sum < 21 && dealer_sum == 21
    return "The dealer won..."
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