class SessionsController < ApplicationController
  def new
    # Rails por defecto renderizará app/views/sessions/new.html.erb
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if params[:session][:remember_me] == '1'
        user.remember # Llama al método remember del modelo para generar y guardar el digest
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token

      else
        user.forget # Llama al método forget del modelo para eliminar el digest
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
      end
      if user.user_role == 'admin'
        redirect_to administracion_path
      elsif
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Email o contraseña inválidos'

      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    current_user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session[:user_id] = nil
    redirect_to root_path, status: :see_other
  end
end
