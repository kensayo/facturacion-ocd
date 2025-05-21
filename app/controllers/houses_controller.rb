class HousesController < ApplicationController
  has_many :users, dependent: :nullify
end
