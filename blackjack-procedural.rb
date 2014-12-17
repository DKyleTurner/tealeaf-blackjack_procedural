# Add up each player's hand and account for Aces being 1 or 11 when appropriate
def sum_cards(hand)
  cards_total = hand.map {|i| i[0]}
  aces_arr = []
  added_cards = 0
  cards_total.each do |val|
    if val.to_i == 0 && val != 'Ace'
      added_cards += 10
    elsif val == 'Ace'
      added_cards += 11
      aces_arr << val
    else
      added_cards += val
    end
    if added_cards > 21 && aces_arr.include?('Ace')
      added_cards -= 10
      aces_arr.pop
    end
  end
  added_cards
end

def card_display(cards)
  hand = cards.map {|i| i}
  hand.each {|val| puts "#{val[0]} of #{val[1]}"}
end

play_again = 'y'
player_funds = 500

# Greeting
puts "This...Is...BLACKJACK!\n"
puts "\n"
puts "You look lucky! What's your name?"
player_name = gets.chomp
system('clear')

# Main game logic
loop do
  if player_funds == 0
    puts "You're out of money, go pawn your car or something."
    sleep(3)
    exit
  end
  puts "Ladies and gentlemen, please place your bets."
  puts "#{player_name}, you have $#{player_funds}."

  begin
    player_bet = gets.chomp.to_i
    system('clear')
    if player_bet == 0
      puts "Sorry, please enter a value between 1 and #{player_funds} with no preceding or trailing characters."
    elsif player_bet > player_funds
      puts "You don't have that much money."
    end
  end while player_bet == 0 || player_bet > player_funds

  card_suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  # Combine the 2 arrays then shuffle the deck
  deck_of_cards = card_values.product(card_suits).shuffle!

  shoe = deck_of_cards.dup.shuffle!

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
    puts "#{player_name} bets $#{player_bet}"
    puts "\n"

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
      if player_total == 21
        system('clear')
        puts "#{player_name}'s Cards:"
        puts "~~~~~~~~~~~~~"
        card_display(player_cards)
        puts "\n#{player_name}'s Total: #{player_total}"
        player_funds += player_bet
        puts "\n* * * * * * * * * * * * * * * * * * * * *"
        puts "> #{player_name.upcase} GOT BLACKJACK! YOU WIN $#{player_bet}! <"
        puts "* * * * * * * * * * * * * * * * * * * * * "
        puts "\n"
        puts "Play again? y/n"
        play_again = gets.chomp
        if play_again.downcase == 'n'
          exit
        end
        system('clear')
      elsif player_total > 21
        system('clear')
        puts "#{player_name}'s Cards:"
        puts "~~~~~~~~~~~~~"
        card_display(player_cards)
        puts "\n#{player_name}'s Total: #{player_total}"
        player_funds -= player_bet
        puts "\n* * * * * * * * * * * * * * * *"
        puts "> #{player_name.upcase} BUSTS. HOUSE WINS $#{player_bet}.<"
        puts "* * * * * * * * * * * * * * * *"
        puts "\n"
        puts "Play again? y/n"
        play_again = gets.chomp
        if play_again.downcase == 'n'
          exit
        end
        system('clear')
      end
    elsif player_response.downcase == "stay"
      puts"\n"
      puts "> #{player_name.upcase} STAYS AT #{player_total} <"
      puts "\n"
        if player_total == 21
          player_funds += player_bet
          puts "\n* * * * * * * * * * * * * * * * * * * * *"
          puts "> #{player_name} GOT BLACKJACK! YOU WIN $#{player_bet}! <"
          puts "* * * * * * * * * * * * * * * * * * * * * "
          puts "\n"
          puts "Play again? y/n"
          play_again = gets.chomp
          if play_again.downcase == 'n'
            exit
          end
          system('clear')
        end
      break
    else
      system('clear')
      puts "Please choose one of the valid commands"
    end
  end while player_total < 22

  # Dealer game logic
  if player_response == 'stay' && player_total < 21
    begin
      dealer_total = sum_cards(dealer_cards)
      puts "Dealer Cards:"
      puts "~~~~~~~~~~~~~~~"
      card_display(dealer_cards)
      puts "Dealer Total: #{dealer_total}"
      if dealer_total > 16 && dealer_total < 21
        puts "\n"
        puts "> DEALER STAYS AT #{dealer_total} <"
        break
      elsif dealer_total < 17
        puts "\n"
        sleep(2)
        puts ">DEALER HITS<"
        puts "\n"
        dealer_cards << shoe.pop
      elsif dealer_total > 21
        player_funds += player_bet
        puts "\n* * * * * * * * * * * * * * * * * * *"
        puts " > DEALER BUSTS! YOU WIN $#{player_bet}! <"
        puts "* * * * * * * * * * * * * * * * * * *"
        puts "\n"
        puts "Play again? y/n"
        play_again = gets.chomp
        if play_again.downcase == 'n'
          exit
        end
        system('clear')
      elsif dealer_total == 21
        player_funds -= player_bet
        puts "\n* * * * * * * * * * * * * * * *"
        puts "> DEALER BLACKJACK. HOUSE WINS $#{player_bet}...go hit the ATM <"
        puts "* * * * * * * * * * * * * * * *"
        puts "\n"
        puts "Play again? y/n"
        play_again = gets.chomp
        if play_again.downcase == 'n'
          exit
        end
        system('clear')
        break
      end
    end while dealer_total < 22
  end

  # Compare the scores of each player
  if player_response.downcase == 'stay'
    if player_total > dealer_total && player_total < 21
      player_funds += player_bet
      puts "\n* * * * * * * * * * * * * *"
      puts "  > PLAYER WINS $#{player_bet}! <"
      puts "* * * * * * * * * * * * * *"
      puts "\n"
      puts "Play again? y/n"
      play_again = gets.chomp
      if play_again.downcase == 'n'
        exit
      end
      system('clear')
    elsif player_total < dealer_total && dealer_total < 21
      player_funds -= player_bet
      puts "\n* * * * * * * * * * * * * *"
      puts "> HOUSE WINS $#{player_bet} of your money! <"
      puts "* * * * * * * * * * * * * *"
      puts "\n"
      puts "Play again? y/n"
      play_again = gets.chomp
      if play_again.downcase == 'n'
        exit
      end
      system('clear')
    elsif player_total == dealer_total && player_total < 21
      puts "\n* * * * * * * * * * * * * *"
      puts "  > PUSH, IT'S A TIE! <"
      puts "* * * * * * * * * * * * * *"
      puts "\n"
      puts "Play again? y/n"
      play_again = gets.chomp
      if play_again.downcase == 'n'
        exit
      end
      system('clear')
    end
  end
end while play_again == 'y'
