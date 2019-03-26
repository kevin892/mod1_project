class Card < ActiveRecord::Base
  has_many :subscriptions
  has_many :companies, through: :subscriptions
  belongs_to :customer
end
