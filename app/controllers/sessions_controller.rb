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
    user = User.find_by(username: params[:session][:username].downcase)

    # Verifica si el usuario existe Y si la contraseña es correcta usando has_secure_password
    if user && user.authenticate(params[:session][:password])
      # Éxito en el login:
      # 1. Guarda el ID del usuario en la sesión del navegador (cookie)
      session[:user_id] = user.id
      if params[:session][:remember_me] == '1'
        user.remember # Llama al método remember del modelo para generar y guardar el digest
        # Establece una cookie *permanente* en el navegador
        # cookies.permanent.signed[:user_id] = user.id # Esto es para recordar el ID, no el token
        # Debemos recordar el token y el id
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token

      else
        # Si no marcó "Recordarme", asegúrate de que no haya cookie permanente anterior
        user.forget # Llama al método forget del modelo para eliminar el digest
        cookies.delete(:user_id) # Elimina la cookie permanente si existía
        cookies.delete(:remember_token) # Elimina la cookie del token si existía
      end
      # 2. Opcional: Muestra un mensaje de éxito
      # flash[:success] = "¡Bienvenido de nuevo, #{user.name}!"

      # 3. Redirige a alguna página (ej: página principal, perfil del usuario)
      redirect_to root_path # Cambia root_url por la ruta que desees
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

    current_user.forget # Llama al método forget del modelo
    cookies.delete(:user_id) # Elimina la cookie del ID
    cookies.delete(:remember_token) # Elimina la cookie del token
    session[:user_id] = nil # Elimina la sesión estándar
    # flash[:success] = "Sesión cerrada."

    # Opcional: Muestra un mensaje de despedida
    # flash[:success] = "Sesión cerrada correctamente."

    # Redirige a la página principal o a la página de login
    redirect_to root_path, status: :see_other # status: :see_other (303) es el estándar después de un DELETE que redirige
  end
end
