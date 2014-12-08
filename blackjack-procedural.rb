def sum_cards(hand)
  cards_total = hand.map {|i| i[0]}
  added_cards = 0
  cards_total.each do |val|
    (val.to_i == 0) ? added_cards += 10 : added_cards += val
  end
  added_cards
end

def check_for_game_end(player_score, dealer_score)
  msg = "Blackjack! You win!" if player_score == 21 && dealer_score < 21
  msg = "It's a tie! Push!" if player_score == dealer_score
  msg = "Blackjack! You lose!" if player_score < 21 && dealer_score == 21
  msg = "Player busts! You lose!"if player_score > 21 && dealer_score < 21
  msg = "Dealer busts! You win!" if player_score < 21 && dealer_score > 21
  msg
end

def card_display(cards)
  hand = cards.map {|i| i}
  hand.each {|val| puts "#{val[0]} of #{val[1]}"}
end

# Greeting
puts 'This...Is...BLACKJACK!'
puts "\n"

# Card suits
card_suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']

# Card values
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

# Combine the 2 arrays then shuffle the deck
deck_of_cards = card_values.product(card_suits).shuffle!

# Initialize player and dealer hands
dealer_cards = []
player_cards = []

# Start the game
2.times do
  player_cards << deck_of_cards.pop
  dealer_cards << deck_of_cards.pop
end

begin
  puts "Player Cards:"
  puts "~~~~~~~~~~~~~"
  card_display(player_cards)
  player_total = sum_cards(player_cards)
  puts "\nPlayer Total: #{player_total}"

  puts "\nDealer Cards:"
  puts "~~~~~~~~~~~~~~~"
  card_display(dealer_cards)
  dealer_total = sum_cards(dealer_cards)
  puts "\nDealer Total: #{dealer_total}"
  puts "\n"

  dealer_cards << deck_of_cards.pop if dealer_total < 17
  puts "Dealer stays." if dealer_total >= 17

  end_game_msg = check_for_game_end(player_total, dealer_total)
  puts end_game_msg

  puts "Hit or Stay?"
  player_response = gets.chomp

  player_cards << deck_of_cards.pop if player_response.downcase == 'hit'

  if player_response.downcase == "stay"
    check_for_game_end(player_total, dealer_total)
    puts end_game_msg
  else
    puts "Please choose a valid command."
  end
  system('clear')
end until player_response.downcase == 'exit'

# 'Please choose...' output doesn't work
# Need a 'Play Again?' method
# Need to fix the messages that are displayed at the end of the game
# Don't need to keep printing 'dealer stays' after the game is over
# Need to add a betting system