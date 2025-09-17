class AdministrationController < ApplicationController
  before_action :validate_admin_user
  def index
    @houses = House.all
    @user = User.new
    @users = User.all
    @currencies = Currency.all
    @currency = Currency.new
    @transaction_types = TransactionType.all
    @transaction_type = TransactionType.new
  end

  private

  def validate_admin_user
    if current_user.nil? && current_user&.user_role == 'admin'
      redirect_to login_path
    end
  end
end
