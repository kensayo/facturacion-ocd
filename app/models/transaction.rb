class Transaction < ApplicationRecord
  belongs_to :account
  validates :account, presence: true

  belongs_to :user
  validates :user, presence: true

  belongs_to :transaction_type
  validates :transaction_type, presence: true

  scope :gastos, -> { where(transaction_type: 'gasto') }
  scope :ingresos, -> { where(transaction_type: 'ingreso') }
  scope :balance_by_currency, ->(currency_id) {
    where(currency_id: currency_id)
      .group(:transaction_type)
      .sum(:amount)
      .then { |result| (result['ingreso'] || 0) - (result['gasto'] || 0) }.round(2)
  }


  def formatted_amount
    "#{amount} #{currency.symbol} "
  end

  def self.total_coin_value(currency = 'USD')
  end
end
