class AdministrationController < ApplicationController
  before_action :validate_admin_user
  def index
    @houses = House.all
    @users = User.all
    @user = User.new
  end

  private

  def validate_admin_user
    if current_user.nil? && current_user&.user_role == 'admin'
      redirect_to login_path
    end
  end
end
