
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
    # binding.pry
  else
    puts "Name not found! Would you like to create? (Y / N)"
    # binding.pry
    choice = gets
    choice = choice.upcase.chomp!
    # binding.pry
    if choice == 'Y'
      Customer.create(first_name: first, last_name: last)
    else
      puts 'AAHAHAHAHHAHHAHAHAH'
      binding.pry
    end
  end
end

def business_menu
  print 'You made it to the business menu!'
end

def selector(num)
  # binding.pry
    case num.to_i
    when 1
      personal_menu
    when 2
      # binding.pry
      business_menu
    when 102
    else
      binding.pry
    end
end
