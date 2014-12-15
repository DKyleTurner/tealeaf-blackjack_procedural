require 'pry'

def sum_cards(hand)
  cards_total = hand.map {|i| i[0]}
  added_cards = 0
  cards_total.each do |val|
    if val.to_i == 0 && val != 'Ace'
      added_cards += 10
    elsif val == 'Ace'
      added_cards += 11
    else
      added_cards += val
    end
    if added_cards > 21
      hand.each do |v|
        if v.last == 'Ace'
          player_total -= 10
        end
      end
    end
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
puts "You look lucky! What's your name?"
player_name = gets.chomp
card_suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

# Combine the 2 arrays then shuffle the deck
deck_of_cards = card_values.product(card_suits).shuffle!

####### NEED 4 DECKS OF CARDS, SHUFFLED - 'player_cards' etc WILL USE THE NEW 'SHOE'########
shoe = deck_of_cards.dup

2.times do
  shoe += shoe
end

# Initialize player and dealer hands
dealer_cards = []
player_cards = []

player_cards << shoe.pop
dealer_cards << shoe.pop
player_cards << shoe.pop
dealer_cards << shoe.pop

dealer_total = 0
player_total = 0

begin
  puts "* Dealer card: #{dealer_cards.first.first} of #{dealer_cards.first.last} *"
  puts "\n"

  player_total = sum_cards(player_cards)

  puts "#{player_name}'s Cards:"
  puts "~~~~~~~~~~~~~"
  card_display(player_cards)
  puts "\n#{player_name}'s Total: #{player_total}"
  puts "Hit or Stay?"
  player_response = gets.chomp

  if player_response.downcase == 'hit'
    system('clear')
    player_cards << shoe.pop
    player_total = sum_cards(player_cards)
    player_cards.each do |val|
      if val.last == 'Ace' && player_total > 21
        player_total -= 10
      end
    end
  if player_total == 21
    system('clear')
    puts "#{player_name}'s Cards:"
    puts "~~~~~~~~~~~~~"
    card_display(player_cards)
    puts "\n#{player_name}'s Total: #{player_total}"
    puts "\n* * * * * * * * * * * * * * * * * * * * *"
    puts "> #{player_name.upcase} GOT BLACKJACK! YOU WIN! <"
    puts "* * * * * * * * * * * * * * * * * * * * * "
    puts "\n"
    exit
  elsif player_total > 21
    system('clear')
    puts "#{player_name}'s Cards:"
    puts "~~~~~~~~~~~~~"
    card_display(player_cards)
    puts "\n#{player_name}'s: #{player_total}"
    puts "\n* * * * * * * * * * * * * * *"
    puts "> #{player_name.upcase} BUSTS. HOUSE WINS. <"
    puts "* * * * * * * * * * * * * * *"
    puts "\n"
    exit
  end
  elsif player_response.downcase == "stay"
    puts"\n"
    puts "> #{player_name.upcase} STAYS AT #{player_total} <" if
    puts "\n"
    puts
      if player_total == 21
        puts "\n* * * * * * * * * * * * * * * * * * * * *"
        puts "> #{player_name} GOT BLACKJACK! YOU WIN! <"
        puts "* * * * * * * * * * * * * * * * * * * * * "
        puts "\n"
      end
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
    puts "\n"
    puts "> DEALER STAYS AT #{dealer_total} <"
    puts "\n"
    break
  elsif dealer_total < 17
    puts "\n"
    puts ">DEALER HITS<"
    puts "\n"
    dealer_cards << shoe.pop
  elsif dealer_total > 21
    puts "\n* * * * * * * * * * * * * *"
    puts " > DEALER BUSTS! YOU WIN! <"
    puts "* * * * * * * * * * * * * *"
    puts "\n"
    break
  elsif dealer_total == 21
    puts "\n* * * * * * * * * * * * * * * *"
    puts "> DEALER BLACKJACK. HOUSE WINS. <"
    puts "* * * * * * * * * * * * * * * *"
    puts "\n"
    break
  end
end while dealer_total < 22

if player_response.downcase == 'stay'
  if player_total > dealer_total && player_total < 21
    puts "\n* * * * * * * * * * * * * *"
    puts "      > PLAYER WINS! <"
    puts "* * * * * * * * * * * * * *"
    puts "\n"
  elsif player_total < dealer_total && dealer_total < 21
    puts "\n* * * * * * * * * * * * * *"
    puts "      > DEALER WINS. <"
    puts "* * * * * * * * * * * * * *"
    puts "\n"
  elsif player_total == dealer_total && player_total < 21
    puts "\n* * * * * * * * * * * * * *"
    puts "  > PUSH, IT'S A TIE! <"
    puts "* * * * * * * * * * * * * *"
    puts "\n"
  end
end