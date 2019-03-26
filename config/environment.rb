require "sinatra/activerecord"
require "pry"




ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/subs.db"
)
