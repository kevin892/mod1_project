class Company < ActiveRecord::Base
  has_many :subscriptions
  has_many :cards, through: :subscriptions
end
