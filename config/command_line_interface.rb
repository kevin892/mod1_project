
def welcome
  puts "Are you a personal or business user?\n1 - Personal\n2 - Business\n"
end


def user_select
  print 'Entry: '
  gets.chomp
end



def personal_menu
  # System('clear')
  puts 'You made it to the personal menu!'
  puts "Please enter your name. \nFirst Name: "
  first = gets.chomp
  puts "\nLast Name: "
  last = gets.chomp
  if Customer.find_by(first_name: first) && Customer.find_by(last_name: last)
    puts "Getting your info..."
    sleep 2
    puts "Welcome #{first} #{last}"
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
      new_customer = Customer.create(first_name: first, last_name: last)
      puts "#{first}'s profile added!"
      new_customer
    else
      puts 'Ok, Goodbye'
      sleep 2
    end
  end
end

def business_menu
  puts 'You made it to the business menu!'
  puts "Please enter company name: "
  company = gets.chomp
  if Company.find_by(name: company)
    puts "Getting your info..."
    sleep 2
    puts "Welcome #{company}"
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
      new_company = Company.create(name: company)
      puts "#{company}'s profile added!"
      new_company
    else
      puts 'Ok, Goodbye'
      sleep 2
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
    when 110 || 210
      return 1
    when 201
      company_subscriptions(user)
    when 202
      customers_count(user)
    when 203
      company_customers(user)
    when 204
      monthly_income(user)
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
  if user.subscriptions.map(&:name).empty?
    puts "You dont have any subscriptions yet."
  else
  puts user.subscriptions.map(&:name)
  end
  sleep 4
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
  i = 0
  while !Company.all.map(&:name).include?(company) && i <= 1
    puts "Company not found, are any of these the company you are looking for?"
    puts Company.all.map(&:name)
    company = user_select
    # puts "Company not found, try again."
    i+=1
  end

  puts "Would you like to create #{company}? (Y/N)"
  answer = user_select
  if answer == "y"|| answer =="Y"
    Company.create(name: company)
  else
    puts"Creation Canceled!"
    sleep 2
    return
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

  if due == 1 || due == 21 || due ==  31
    puts "Your next bill is due on the #{due}st"
  elsif due == 2 || due == 22
    puts "Your next bill is due on the #{due}nd"
  elsif due == 3 || due == 23
  puts "Your next bill is due on the #{due}rd"
else
  puts "Your next bill is due on the #{due}th"
  end
  sleep 3
end

def view_companies(user)
  puts user.subscriptions.map{|sub| sub.company.name}.uniq
  sleep 4
  # binding.pry
end

def business_menu_01(user)
  control = 0
  while control == 0
    puts "What would you like to do?\n1 - View Subscriptions\n2 - User Count\n3 - Get Customers\n4 - Monthly Income\n10 - Exit"
    c = selector(user_select.to_i+200, user)
    control = c if c ==1
  end
end

def company_subscriptions(user)
  if user.subscriptions.map(&:name).empty?
    puts "You dont have any subscriptions yet."
  else
  puts user.subscriptions.map(&:name)
  end
  sleep 4
end

def monthly_income(user)
   if user.subscriptions.map(&:amount).empty?
  puts "#{user.name} isn't making any money yet."
  else
  puts "#{user.name} makes $#{user.subscriptions.map(&:amount).reduce(&:+)} per month."
  end
sleep 4
end

def company_customers(user)
  if user.subscriptions.map{|sub| sub.customer.fullname}.empty?
    puts "You dont have any customers yet."
  else
  puts user.subscriptions.map{|sub| sub.customer.fullname}.uniq
  end
  sleep 4
end

def customers_count(user)
  puts user.subscriptions.map{|sub| sub.customer.fullname}.uniq.count
  sleep 4
end



# puts user.subscriptions.map{|sub| sub.company.name}.uniq
