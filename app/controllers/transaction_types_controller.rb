class TransactionTypesController < ApplicationController
  before_action :set_transaction_type, only: %i[ destroy ]

  def create
    @transaction_type = TransactionType.new(transaction_type_params)
    respond_to do |format|
      if @transaction_type.save
        new_transaction_type = @transaction_type
        @transaction_type = TransactionType.new
        format.html { redirect_to administracion_path, notice: 'Rubro creada exitosamente.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('transaction_types-list', partial: 'transaction_types_list', locals: { transaction_type: new_transaction_type }),
            turbo_stream.replace('transaction_type_form_container', partial: 'transaction_types/form', locals: { transaction_type: @transaction_type })
          ]
        end
      else
        flash[:alert] = 'Error al crear Rubro'
        redirect_to administracion_path
      end
    end
  end

  def destroy
    begin
      @transaction_type.destroy!
      respond_to do |format|
        format.html { redirect_to administracion_path, notice: 'Rubro eliminado exitosamente.' }
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@transaction_type) }
      end
    rescue  StandardError
        flash[:alert] = "Error al eliminar Rubro: #{@transaction_type.transactions.count} transacciones dependen del rubro #{@transaction_type.name}"
        redirect_to administracion_path
    end
  end

  private

  def set_transaction_type
    @transaction_type = TransactionType.find(params.expect(:id))
  end

  def transaction_type_params
    params.require(:transaction_type).permit(:name, :description, :code)
  end
end
