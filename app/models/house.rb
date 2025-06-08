class House < ApplicationRecord
  has_many :accounts, dependent: :nullify
  has_many :users, dependent: :nullify
end
