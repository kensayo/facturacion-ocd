class Currency < ApplicationRecord
  has_many :transactions, dependent: :restrict_with_error

  validates :code, presence: true, uniqueness: true
  validates :symbol, :name, presence: true

  def display_code
    "#{code} (#{symbol})"
  end

  def full_name
    "#{name} (#{code})"
  end
end
