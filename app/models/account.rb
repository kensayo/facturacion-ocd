class Account < ApplicationRecord
  has_many :transactions, dependent: :nullify
  belongs_to :currency
  belongs_to :house
end
