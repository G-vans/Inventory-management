class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy increase_stock decrease_stock ]

  # GET /products or /products.json
  def index
    @products = Product.search(params[:name])
    @low_stock_products = Product.low_stock

    if @low_stock_products.present?
      low_stock_names = @low_stock_products.map(&:name).join(", ")
      flash.now[:notice] = "#{low_stock_names} #{'are' if @low_stock_products.count > 1} low on stock"
    end

    @product = Product.new

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end  
  

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #stock increase and decrease
  def increase_stock
    amount = params[:amount] ? params[:amount].to_i : 1
    @product.increment!(:quantity, amount)
    respond_to do |format|
      format.html { redirect_to products_url }
      format.turbo_stream
    end
  end

  def decrease_stock
    amount = params[:amount] ? params[:amount].to_i : 1
    @product.decrement!(:quantity, amount)
    respond_to do |format|
      format.html { redirect_to products_url }
      format.turbo_stream
    end
  end

  def update_stock
    if product.quantity <= 10
      low_stock_notification(product)
    end
  end

  #notifications display
  def low_stock_notification
    product = Product.find(params[:id])
    Turbo::StreamsChannel.broadcast_replace_to(
      "product_notifications",
      target: "low_stock_notification_#{product.id}",
      partial: "products/notification",
      locals: { product: product }
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity, :image)
    end
end
