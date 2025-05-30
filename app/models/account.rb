class Account < ApplicationRecord
  has_many :transactions, dependent: :nullify
  belongs_to :currency
  belongs_to :house

  delegate :symbol, to: :currency

  COLORS = %w[pastel-blue pastel-green pastel-yellow pastel-purple pastel-pink pastel-orange pastel-teal pastel-lavender
          pastel-peach pastel-mint].freeze

  def pretty_balance
    balance.to_s + ' ' + symbol
  end
end
