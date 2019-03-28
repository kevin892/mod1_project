
require_relative 'config/environment.rb'



welcome
# user = nil
# while user == nil
user = selector(user_select)
# end
# personal_menu
# binding.pry

personal_menu_01(user) if user.class == Customer
business_menu_01(user) if user.class == Company




# puts user

# binding.pry
