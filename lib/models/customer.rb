class Customer < ActiveRecord::Base
  has_many :subscriptions
  has_many :companies, through: :subscriptions

  def fullname
    "#{first_name} #{last_name}"
  end
end
