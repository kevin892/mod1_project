require "sinatra/activerecord"
require_relative 'config/command_line_interface.rb'
require "pry"




ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/subs.db"
)
