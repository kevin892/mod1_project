
require_relative 'config/environment.rb'



welcome
user = selector(user_select)

# personal_menu
# binding.pry

personal_menu_01(user) if user.class == Customer
business_menu_01(user) if user.class == Company

# puts user

# binding.pry
