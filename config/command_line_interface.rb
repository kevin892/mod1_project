
def welcome
  puts "Are you a personal or business user?\n1 - personal\n2 - business\n"
end


def user_select
  print 'Entry: '
  gets.chomp
end



def personal_menu
  # System('clear')
  puts 'You made it to the personal menu!'
  puts "Please enter your name. \nFirst: "
  first = gets.chop
  puts "\nLast: "
  last = gets.chomp
  if Customer.find_by(first_name: first) && Customer.find_by(last_name: last)
    puts "Welcome #{first} #{last}"
    sleep 1
    puts "Getting your info..."
    sleep 2
    # binding.pry
    return Customer.find_by(first_name: first, last_name: last)
  else
    puts "Name not found! Would you like to create? (Y / N)"
    # binding.pry
    choice = gets
    choice = choice.upcase.chomp!
    # binding.pry
    if choice == 'Y'
      Customer.create(first_name: first, last_name: last)
      puts "#{first}'s profile added!'"
    else
      puts 'AAHAHAHAHHAHHAHAHAH'
      binding.pry
    end
  end
end

def business_menu
  print 'You made it to the business menu!'
end

def selector(num, user=nil)
  # binding.pry
    case num.to_i
    when 1
      personal_menu
    when 2
      # binding.pry
      business_menu
    when 101
      view_subscriptions
    when 102
      add_subscription
    when 103
      view_cards
    when 104
      add_card
    else
      binding.pry
    end
end

def personal_menu_01(user)
  puts "What would you like to do?\n 1 - View Subscriptions\n2 - Add Subscription\n3 - View Cards\n4 - Add Cards"
  selector(user_select, user)
end
