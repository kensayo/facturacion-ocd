class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_houses, only: [ :new, :create, :edit, :update ]
  before_action :load_users, only: [ :edit, :new, :index ]

  # GET /users
  def index
  end
  def new
    @user = User.new
    # Responde con un Turbo Stream para reemplazar el contenedor del formulario
    respond_to do |format|
      format.html { render 'administration/index' } # Fallback for non-JS requests
      format.turbo_stream do
          render(partial: 'users/form', locals: { user: User.new })
      end
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        new_user = @user
        @user = User.new
        format.html { redirect_to administracion_path, notice: 'Usuario creado exitosamente.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('operators-list', partial: 'user_row', locals: { user: new_user }), # Asegúrate de tener _user_row.html.erb
            turbo_stream.replace('user_form_container', partial: 'users/form', locals: { user: @user }) # Resetear el formulario
          ]
        end
      else
        format.html { render 'administration/index', status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'user_form_container',
            partial: 'users/form', #
            locals: { user: @user, houses: @houses }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  # GET /users/:id/edit (Esta acción ahora responderá con el formulario de edición via Turbo Stream)
  def edit
    # @user está establecido por before_action
    # @houses está establecido por before_action
    respond_to do |format|
      format.html { render 'administration/index' } # Fallback for non-JS requests
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace( # No necesitas el array si es solo un replace
          'user_form_container',
          partial: 'users/form', # <-- Solo partial: 'users/form'
          locals: { user: @user, houses: @houses }
        )
      end
    end
  end

  # PATCH/PUT /users/:id
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to administration_path, notice: 'Usuario actualizado exitosamente.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@user, partial: 'user_row', locals: { user: @user }),
            turbo_stream.replace('user_form_container', partial: 'users/form', locals: { user: User.new })
          ]
        end
      else
        format.html { render 'administration/index', status: :unprocessable_entity }
        format.turbo_stream do
          # Si falla, reemplazar el formulario con los errores
          render turbo_stream: turbo_stream.replace(
            'user_form_container',
            render(partial: 'users/form', locals: { user: @user })
          ), status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to administration_path, notice: 'Usuario eliminado exitosamente.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@user) } # Elimina la fila del usuario de la tabla
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_houses
    @houses = House.all
  end

  def load_users
    @users = User.all
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :username, :password, :password_confirmation, :birthdate, :house_id)
  end
end
