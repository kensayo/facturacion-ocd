class Transaction < ApplicationRecord
  belongs_to :account
  validates :account, presence: true

  belongs_to :user
  validates :user, presence: true

  belongs_to :transaction_type
  validates :transaction_type, presence: true

  has_one :currency, through: :account

  delegate :name, to: :transaction_type, prefix: true
  delegate :username, to: :user
  delegate :house, to: :user

  scope :gastos, -> { where(is_income: false) }
  scope :ingresos, -> { where(is_income: true) }
  scope :transactions_by_house, ->(house_users) { where(user: house_users) }

  def formatted_amount
    "#{amount} #{currency.symbol}"
  end
end
