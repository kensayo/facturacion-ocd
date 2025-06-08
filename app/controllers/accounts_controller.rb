class AccountsController < ApplicationController
  has_many :users, dependent: :nullify
end
