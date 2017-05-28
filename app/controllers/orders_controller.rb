class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def search
    if params.has_key?('search')
      @orders = Order.search(params['search'])
    else
      @orders = []
    end
    params['search'] ||= {}
    @old_tariff_name      = params.has_key?('search') ? params[:search][:tariff_name] : ""
    @old_time_of_day      = params.has_key?('search') ? params[:search][:time_of_day] : ""
    @old_range            = params.has_key?('search') ? params[:search][:range] : ""
    @old_automobile_model = params.has_key?('search') ? params[:search][:automobile_model] : ""
    @old_automobile_type  = params.has_key?('search') ? params[:search][:automobile_type] : ""
    @old_color            = params.has_key?('search') ? params[:search][:color] : ""
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    # @order.build_tariff
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:time_of_travel, :departure_address, :arrival_address, :number_of_passengers, :length_of_route, :automobile_id,
      :tariff_id, tariff_attributes: [:_destroy, :id, :name, :time_of_day, :range, :price_per_kilometer])
    end
end
