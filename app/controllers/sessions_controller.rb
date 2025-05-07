# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  # GET /login
  # Muestra el formulario de inicio de sesión.
  def new
    # Rails por defecto renderizará app/views/sessions/new.html.erb
  end

  # POST /login
  # Procesa los datos enviados desde el formulario de login.
  def create
    # Busca al usuario por email (asegurando que sea insensible a mayúsculas/minúsculas)
    user = User.find_by(email: params[:session][:email].downcase)

    # Verifica si el usuario existe Y si la contraseña es correcta usando has_secure_password
    if user && user.authenticate(params[:session][:password])
      # Éxito en el login:
      # 1. Guarda el ID del usuario en la sesión del navegador (cookie)
      session[:user_id] = user.id

      # 2. Opcional: Muestra un mensaje de éxito
      # flash[:success] = "¡Bienvenido de nuevo, #{user.name}!"

      # 3. Redirige a alguna página (ej: página principal, perfil del usuario)
      redirect_to expenses_path # Cambia root_url por la ruta que desees
    else
      # Fallo en el login:
      # 1. Muestra un mensaje de error que solo dure en esta petición (flash.now)
      flash.now[:danger] = 'Email o contraseña inválidos'

      # 2. Vuelve a mostrar el formulario de login
      render 'new', status: :unprocessable_entity # status: :unprocessable_entity (422) es el estándar para errores de validación
    end
  end

  # DELETE /logout
  # Cierra la sesión del usuario actual.
  def destroy
    # Elimina el ID del usuario de la sesión
    session[:user_id] = nil # O usa reset_session para borrar toda la sesión

    # Opcional: Muestra un mensaje de despedida
    # flash[:success] = "Sesión cerrada correctamente."

    # Redirige a la página principal o a la página de login
    redirect_to root_url, status: :see_other # status: :see_other (303) es el estándar después de un DELETE que redirige
  end
end