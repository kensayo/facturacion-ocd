# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base # Asegúrate de que tus controladores de frontend hereden de Base
  # Si estás construyendo una API pura, tus controladores deberían heredar de ActionController::API y usar autenticación basada en tokens.
  # Pero para un frontend con sesiones, ActionController::Base es lo correcto.

  # Hace que estos métodos estén disponibles tanto en controladores como en vistas
  helper_method :current_user, :logged_in?

  # Busca y retorna el usuario actualmente logueado (si existe)
  # Usa memoización (@current_user) para evitar consultas repetidas a la base de datos en la misma petición
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      # Verifica si el usuario existe y si el token en la cookie coincide con el digest en la BD
      if user && user.authenticated?(cookies[:remember_token])
        # Usuario autenticado vía cookie permanente:
        session[:user_id] = user.id # Restablece la sesión estándar para futuras peticiones
        @current_user = user # Establece @current_user
      end
    end
    @current_user
  end

  # Retorna true si hay un usuario logueado, false en caso contrario
  def logged_in?
    !current_user.nil? # O !!current_user para asegurar un valor booleano estricto
  end

  # Método para redirigir usuarios no logueados a la página de login
  def require_user_logged_in!
    unless logged_in?
      # Opcional: mensaje flash para informar al usuario
      # flash[:danger] = "Por favor, inicia sesión para acceder a esta página."
      redirect_to login_url # Redirige a la ruta del login
    end
  end
end
