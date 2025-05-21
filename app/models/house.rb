class House < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :expenses, dependent: :nullify
end
