class Expense < ApplicationRecord
  belongs_to :house
  validates :house, presence: true

  belongs_to :user
  validates :user, presence: true

  before_create :set_house

  VALID_COIN_TYPES = %w[USD VES EUR COP].freeze
  validates :currency, inclusion: { in: VALID_COIN_TYPES }

  after_initialize :set_house, if: :new_record?

  private
  def set_house
    self.house = user.house if user
  end
end
