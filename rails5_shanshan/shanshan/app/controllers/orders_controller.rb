class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

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
    @users=User.all.map { |emp| [emp['username'], emp['id']] }
    @products=Product.all.map { |emp| [emp['name'], emp['id']] }
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  # 使用post请求提示：Can't verify CSRF token authenticity
  skip_before_action :verify_authenticity_token
  def create
    @order = Order.new(params_hash)
    
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

  # 统计所有商品分类的总销售额
  def category_report
    @total =Order.joins(:product).group(:category).select("category,sum(price*num) as totalPrice")
    # respond_to do |format|
    #   format.html { redirect_to orders_url, notice: 'Order was successfully' }
    #   format.json { render :show, status: :ok, location: @total }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :product_id, :num, :batch_id)
    end

    def params_hash
      {:user_id=>params[:user_id],:product_id=>params[:product_id],:num=>params[:num],:batch_id=>params[:batch_id]}
    end

end
