class Order < ApplicationRecord
  belongs_to :customer
  has_many :payments
  has_and_belongs_to_many :items

  accepts_nested_attributes_for :customer, :items, :payments

end
