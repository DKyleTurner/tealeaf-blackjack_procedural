require 'pry'

def sum_cards(hand)
  cards_total = hand.map {|i| i[0]}
  added_cards = 0
  cards_total.each do |val|
    (val.to_i == 0) ? added_cards += 10 : added_cards += val
  end
  added_cards
end

def card_display(cards)
  hand = cards.map {|i| i}
  hand.each {|val| puts "#{val[0]} of #{val[1]}"}
end

# Greeting
puts "This...Is...BLACKJACK!\n"
puts "\n"
card_suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

# Combine the 2 arrays then shuffle the deck
  deck_of_cards = card_values.product(card_suits).shuffle!

####### NEED 4 DECKS OF CARDS, SHUFFLED - 'player_cards' etc WILL USE THE NEW 'SHOE'########
a = deck_of_cards.dup
shoe = a + deck_of_cards
puts shoe.length

# Initialize player and dealer hands
dealer_cards = []
player_cards = []

player_cards << deck_of_cards.pop
dealer_cards << deck_of_cards.pop
player_cards << deck_of_cards.pop
dealer_cards << deck_of_cards.pop

dealer_total = 0
player_total = 0

begin

  player_total = sum_cards(player_cards)
  puts "Player Cards:"
  puts "~~~~~~~~~~~~~"
  card_display(player_cards)
  puts "\nPlayer Total: #{player_total}"
  puts "Shoe #{shoe.length}"
  puts "Hit or Stay?"
  player_response = gets.chomp

  if player_response.downcase == 'hit'
    system('clear')
    player_cards << deck_of_cards.pop
    player_total = sum_cards(player_cards)
    puts "\nPlayer Total: #{player_total}"
  if player_total == 21
    puts "Blackjack! Player wins!!"
  elsif player_total > 21
    puts "Player busts...you lose..."
    exit
  end

  elsif player_response.downcase == "stay"
    system('clear')
    puts ">PLAYER STAYS AT #{player_total}<"
    break
  else
    system('clear')
    puts "Please choose one of the valid commands"
  end
end while player_total < 22

begin
  dealer_total = sum_cards(dealer_cards)
  puts "Dealer Cards:"
  puts "~~~~~~~~~~~~~~~"
  card_display(dealer_cards)
  puts "Dealer Total: #{dealer_total}"
  if dealer_total > 16 && dealer_total < 21
    puts "Dealer stays at #{dealer_total}."
    break
  elsif dealer_total < 17
    puts "Dealer hits"
    dealer_cards << deck_of_cards.pop
  elsif dealer_total > 21
    puts "Dealer busts."
    break
  elsif dealer_total == 21
    puts "Dealer blackjack."
    break
  end
end while dealer_total < 22

if player_response.downcase == 'stay'
  if player_total > dealer_total && player_total < 21
    puts "Player wins!"
  elsif player_total < dealer_total && dealer_total < 21
    puts "Dealer wins!"
  elsif player_total == dealer_total && player_total < 21
    puts "Push! It's a tie!"
  end
end