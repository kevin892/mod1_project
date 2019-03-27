require "sinatra/activerecord"
require_relative 'command_line_interface.rb'
require "pry"
require 'require_all'
require_all 'lib'
require 'date'




ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/subs.db"
)
