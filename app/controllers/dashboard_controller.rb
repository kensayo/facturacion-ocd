class DashboardController < ApplicationController
  before_action :validate_user
  def index
    redirect_to administracion_path if current_user.user_role == 'admin'
    @user = current_user
    @transactions = Transaction.transactions_by_house(@user.house.users)
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
