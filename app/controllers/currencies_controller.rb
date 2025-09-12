class CurrenciesController < ApplicationController
  before_action :set_currency, only: %i[ show edit update destroy ]

  def index
    @currency = Currency.all
  end

  # GET /Currency/1
  def show
  end

  # GET /Currency/new
  def new
    @currency = Currency.new
  end

  # GET /Currency/1/edit
  def edit
  end

  # POST /Currency
  def create
    @currency = Currency.new(currency_params)
    respond_to do |format|
      if @currency.save
        new_currency = @currency
        @currency = Currency.new
        format.html { redirect_to administracion_path, notice: 'Moneda creada exitosamente.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('currencies-list', partial: 'currency_list', locals: { currency: new_currency }),
            turbo_stream.replace('currency_form_container', partial: 'currencies/form', locals: { currency: @currency })
          ]
        end
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /Currency/1
  def update
    if @currency.update(currency_params)
      redirect_to @currency, notice: 'Currency was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /Currency/1
  def destroy
    @currency.destroy!
    respond_to do |format|
      format.html { redirect_to administration_path, notice: 'Moneda eliminada exitosamente.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@currency) }
    end
  end

  private

  def set_currency
    @currency = Currency.find(params.expect(:id))
  end

  def currency_params
    params.require(:currency).permit(:name, :symbol, :code)
  end
end
