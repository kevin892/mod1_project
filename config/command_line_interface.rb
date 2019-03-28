
def welcome
  puts `clear`
  puts "\nWelcome to Scribed!"
  sleep 1
  puts "\nAre you a personal or business user?\n1 - Personal\n2 - Business\n"
end


def user_select
  print "\nEntry: "
  gets.chomp
end



def personal_menu
  puts `clear`
  puts "\nYou made it to the personal menu!\n"
  sleep 1
  puts "\nPlease enter your name: \n\nFirst Name "
  print " Entry: "
  first = gets.chomp
  puts "\nLast Name "
  print " Entry: "
  last = gets.chomp
  puts `clear`
  if Customer.find_by(first_name: first) && Customer.find_by(last_name: last)
    puts "\nGetting your info...\n"
    sleep 1
    puts "\nWelcome, #{first} #{last}!\n"
    sleep 1
    # binding.pry
    return Customer.find_by(first_name: first, last_name: last)
  else
    puts "Name not found! Would you like to create? (Y / N)\n"
    # binding.pry
    choice = gets
    choice = choice.upcase.chomp!
    # binding.pry
    if choice == 'Y'
      new_customer = Customer.create(first_name: first, last_name: last)
      puts "#{first}'s profile added!"
      new_customer
    else
      puts `clear`
      puts 'Ok, Goodbye'
      # sleep 2
    end
  end
end

def business_menu
  puts `clear`
  puts "\nYou made it to the business menu!\n"
  sleep 1
  puts "\nPlease enter company name: \n\nCompany Name: "
  company = gets.chomp
  if Company.find_by(name: company)
    puts "\nGetting your info...\n"
    sleep 1
    puts "\nWelcome, #{company}!\n"
    sleep 1
    # binding.pry
    return Company.find_by(name: company)
  else
    puts "Company not found! Would you like to create? (Y / N)\n"
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
      # sleep 2
    end
  end
end

def selector(num, user=nil)
  # binding.pry
    num = num.to_i
    if user == nil
      while num != 1 && num != 2
        puts "Please enter a valid selection"
        num = user_select.to_i
      end
    elsif user.class == Customer
      while !(101..108).include?(num) && num!=110
        puts "Please enter a valid selection"
        num = user_select.to_i+100
      end
    elsif user.class == Company
      while !(201..204).include?(num) && num !=210
        puts "Please enter a valid selection"
        num = user_select.to_i+200
      end
    end


    # binding.pry
    case num.to_i
    when 1
      personal_menu
    when 2
      # binding.pry
      business_menu
    when 101
      view_subscriptions(user)
      sleep 5
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
    when 108
      all_dates(user)
    when 107
      view_companies(user)
    when 110 || 210
      puts 'Thanks for using Scribed! Goodbye✌️'
      sleep 5
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
      puts 'Thanks for using Scribed! Goodbye✌️'
      sleep 5
      return 1
    end
end

def personal_menu_01(user)

  control = 0
  while control == 0
    puts "\nWhat would you like to do?\n\n1 - View Subscriptions\n2 - Add Subscription\n3 - View Total Monthly Expenses\n4 - Update Subscription\n5 - Delete Subscription\n6 - Next due date\n7 - Companies subscribed to\n8 - All due dates\n10 - Exit"
    c = selector(user_select.to_i+100, user)
    control = c if c ==1
    puts `clear`
  end
end

def view_subscriptions(user)
  if user.subscriptions.map(&:name).empty?
    puts "You dont have any subscriptions yet."
  else
    puts "These are the subscriptions you currently have: \n\n"
  puts user.subscriptions.map(&:name)
  end
  # sleep 1
  # binding.pry
end

def add_subscription(user)
  puts `clear`
  puts "Adding subscription"
  print "\nWhat is the name of the subscription?\n"
  name = user_select
  print "\nWhat day of the month is it processed?\n"
  dotm = user_select.to_i
  print "\nHow much is the bill?\n"
  bill_amount = user_select
  print "\nWhich catagory is this subscription?\n"
  # sub_cat_selector()
  desc = user_select
  print "\nWhat company is the subscription with?\n"
  company = user_select
  # binding.pry
  i = 0
  while !Company.all.map(&:name).include?(company) && i < 1
    puts `clear`
    puts "Company not found, are any of these the company you are looking for?"
    puts Company.all.map(&:name)
    company = user_select
    # puts "Company not found, try again."
    i+=1
  end
  if !Company.all.map(&:name).include?(company)
    puts "Would you like to create #{company}? (Y/N)"
  answer = user_select
  if answer == "y"|| answer =="Y"
    Company.create(name: company)
  else
    puts"Creation Canceled!"
    sleep 1
    return
  end

  end

  new_sub =Subscription.create(name: name, payment_process_date: dotm, amount: bill_amount, subscription_type: desc)
  user.subscriptions << new_sub
  Company.find_by(name:company).subscriptions << new_sub
  puts "Subscription created!"
  sleep 2
end

def view_expenses(user)
  puts "Your total monthly expenses are $#{user.subscriptions.sum(:amount)}."
  sleep 5
end

def check_for_subs(user)
  if user.subscriptions.empty?
    sleep 3
    puts `clear`
    return 1
  end
end

def update_subscription(user)
  puts `clear`
  puts "Which subscription would you like to update?"
  view_subscriptions(user)
  return if check_for_subs(user) == 1
  subs = user_select
  subs = user.subscriptions.find{|subscription| subscription.name == subs}
  puts "What would you like to change it to?"
  subs.update(name: user_select)
  puts "Subscription updated!"
  sleep 2
  # binding.pry
end

def delete_subscription(user)
  puts `clear`
  puts "Which subscription would you like to delete?"
  view_subscriptions(user)
  return if check_for_subs(user) == 1
  subs = user_select
  subs = user.subscriptions.find{|subscription| subscription.name == subs}
    if subs.class == Subscription
      subs.destroy
  # view_subscriptions(user)
  puts "#{subs.name} has been deleted! You must restart the program for changes to be reflected"
  else
  puts "invalid selection"
end
  sleep 2
end

def next_bill(user)
  today = Date.today.strftime("%d").to_i
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
  sleep 5
end

def all_dates(user)

  subss = user.subscriptions.map(&:payment_process_date).uniq
   subss.each do |x|
     if x == 1 || x == 21 || x ==  31
       puts "A bill is due on the #{x}st"
     elsif x == 2 || x == 22
       puts "A bill is due on the #{x}nd"
     elsif x == 3 || x == 23
     puts "A bill is due on the #{x}rd"
   else
     puts "A bill is due on the #{x}th"
     end
     # sleep 1
   end

  sleep 5
end

def view_companies(user)
  puts user.subscriptions.map{|sub| sub.company.name}.uniq
  sleep 5
  puts `clear`
  # binding.pry
end

def business_menu_01(user)
  puts `clear`
  control = 0
  while control == 0
    puts "What would you like to do?\n1 - View Subscriptions\n2 - User Count\n3 - Get Customers\n4 - Monthly Income\n10 - Exit"
    c = selector(user_select.to_i+200, user)
    control = c if c ==1
  end
  puts `clear`
end

def company_subscriptions(user)
      puts `clear`
  if user.subscriptions.map(&:name).empty?
    puts "#{user.name} doesn't have any subscriptions yet.\n\n"
  else
    puts "These are the subscriptions #{user.name} currently has: \n\n"
  puts user.subscriptions.map(&:name)
  end
  sleep 5
  puts `clear`
end

def monthly_income(user)
  puts `clear`
   if user.subscriptions.map(&:amount).empty?
  puts "#{user.name} isn't making any money yet.\n\n"
  else
  puts "#{user.name} makes $#{user.subscriptions.map(&:amount).reduce(&:+)} per month.\n\n"
  end
sleep 3
puts `clear`
end

def company_customers(user)
  puts `clear`
  if user.subscriptions.map{|sub| sub.customer.fullname}.empty?
    puts "#{user.name} doesn't have any customers yet.\n\n"
  else
    puts "These are the customers #{user.name} currently has: \n\n"
  puts user.subscriptions.map{|sub| sub.customer.fullname}.uniq
  end
  sleep 4
  puts `clear`
end

def customers_count(user)
  puts `clear`
  puts "#{user.name} has #{user.subscriptions.map{|sub| sub.customer.fullname}.uniq.count} users"
  sleep 4
  puts `clear`
end



# puts user.subscriptions.map{|sub| sub.company.name}.uniq
