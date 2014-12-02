###################################################################################################

player_card_total = 0
dealer_card_total = 0

dealer_hits = false
dealer_stays = false

###################################################################################################

###################################################################################################
# Need to iterate through 'suited_cards' and 'deal' random cards while also removing them
# Ace can equal 1 or 11 depending on the circumstance - if 11 causes the player to bust, it equals
# 1, if not, it equals 11
numbered_cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
face_cards = {jack: 10, queen: 10, king: 10}

suited_cards = {
    hearts: [[numbered_cards], [face_cards]],
    clubs: [[numbered_cards], [face_cards]],
    spades: [[numbered_cards], [face_cards]],
    diamonds: [[numbered_cards], [face_cards]]
}
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

###################################################################################################

player_cards = []

# Right now, this method loops through the 'numbered_cards' array and stops the loop when it is
# more than 21 - Need to remove each number and corresponding suit from the hash
while player_card_total <= 21
  player_cards.push(numbered_cards.sample)
  player_cards.each {|num| player_card_total += num}
  # puts player_cards
  # if player_card_total > 21
  #   puts 'You lose!'
  # end
end

###################################################################################################


