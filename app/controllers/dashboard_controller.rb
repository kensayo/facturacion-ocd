class DashboardController < ApplicationController
  before_action :validate_user
  def index
    @user = current_user
    @transactions = @user.transactions
    @accounts = @user.accounts
    @transaction = Transaction.new(user: current_user)
  end

  private

  def validate_user
    if current_user.nil?
      redirect_to login_path
    end
  end
end
