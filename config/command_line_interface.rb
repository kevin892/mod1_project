
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
  first = gets.chomp
  puts "\nLast: "
  last = gets.chomp
  if Customer.find_by(first_name: first) && Customer.find_by(last_name: last)
    puts "Welcome #{first} #{last}"
    sleep 1
    puts "Getting your info..."
    sleep 1
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
  puts "Please enter company name: "
  company = gets.chomp
  if Company.find_by(name: company)
    puts "Welcome #{company}"
    sleep 1
    puts "Getting your info..."
    sleep 1
    # binding.pry
    return Company.find_by(name: company)
  else
    puts "Company not found! Would you like to create? (Y / N)"
    # binding.pry
    choice = gets
    choice = choice.upcase.chomp!
    # binding.pry
    if choice == 'Y'
      Company.create(name: company)
      puts "#{company}'s profile added!'"
    else
      puts 'AAHAHAHAHHAHHAHAHAH'
      binding.pry
    end
  end
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
      view_subscriptions(user)
    when 102
      add_subscription(user)
    when 103
      view_expenses(user)
    when 104
      update_subscription(user)
    when 105
      delete_subscription(user)
    when 106
      next_bill(user)
    when 107
      view_companies(user)
    when 110
      return 1
    when 201

    else
      binding.pry
    end
end

def personal_menu_01(user)
  control = 0
  while control == 0
    puts "What would you like to do?\n1 - View Subscriptions\n2 - Add Subscription\n3 - View Total Monthly Expenses\n4 - Update Subscription\n5 - Delete Subscription\n6 - Next due date\n7 - Companies subscribed to\n10 - Exit"
    c = selector(user_select.to_i+100, user)
    control = c if c ==1
  end
end

def view_subscriptions(user)
  puts user.subscriptions.map(&:name)
  # binding.pry
  # sleep
end

def add_subscription(user)
  puts "adding sub"
  print "What is the name of the subscription?\n"
  name = user_select
  print "What day of the month is it processed?\n"
  dotm = user_select.to_i
  print "How much is the bill?\n"
  bill_amount = user_select
  print "How would you describe this subscription?\n"
  desc = user_select
  print "What company is the subscription with?\n"
  company = user_select
  # binding.pry
  while !Company.all.map(&:name).include?(company)
    puts "Company not found, try again."
    company = user_select
  end

  new_sub =Subscription.create(name: name, payment_process_date: dotm, amount: bill_amount, subscription_type: desc)
  user.subscriptions << new_sub
  Company.find_by(name:company).subscriptions << new_sub
  puts "Subscription created!"
  sleep 5
end

def view_expenses(user)
  puts "Your total monthly expenses are $#{user.subscriptions.sum(:amount)}."
  sleep 3
end

def update_subscription(user)
  puts "Which subscription would you like to update?"
  view_subscriptions(user)
  subs = user_select
  subs = user.subscriptions.find{|subscription| subscription.name == subs}
  puts "What would you like to change it to?"
  subs.update(name: user_select)
  # binding.pry
end

def delete_subscription(user)
  puts "Which subscription would you like to delete?"
  view_subscriptions(user)
  subs = user_select
  subs = user.subscriptions.find{|subscription| subscription.name == subs}
  binding.pry
  subs.destroy
  # view_subscriptions(user)
  puts "You must restart the program for changes to be reflected"
  sleep 6
end

def next_bill(user)
  today = Date.today.strftime("%d").to_i
  binding.pry
  due = user.subscriptions.map(&:payment_process_date).min_by{|i| (i-today)}

  puts "Your next bill is due on the #{due}th"
    binding.pry
end

def view_companies(user)

end

def business_menu_01(user)
  control = 0
  while control == 0
    puts "What would you like to do?\n1 - View Subscriptions\n2 - Offer Subscription\n3 - View Total Monthly Expenses\n4 - Update Subscription\n5 - Delete Subscription\n6 - Next due date\n10 - Exit"
    c = selector(user_select.to_i+200, user)
    control = c if c ==1
  end
end
