class Currency < ApplicationRecord
  # En currency.rb - CORRECTO
  has_many :accounts, dependent: :restrict_with_error
  has_many :transactions, through: :accounts

  validates :code, presence: true, uniqueness: true
  validates :symbol, :name, presence: true

  before_destroy :check_for_transactions

  def display_code
    "#{code} (#{symbol})"
  end

  def full_name
    "#{name} (#{code})"
  end

  def check_for_transactions
    if transactions.exists?
      errors.add(:base, 'Cannot delete currency with associated transactions')
      throw :abort
    end
  end
end
