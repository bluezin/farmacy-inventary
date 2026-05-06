class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [ :edit, :update, :destroy ]

  def index
    @products = current_user.products

    if params[:query].present?
      @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to products_path, notice: "Producto creado"
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "Producto actualizado"
    else
      render :edit
    end
  end

  def edit
  end

  def show
    @product = current_user.products.find(params[:id])
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Producto eliminado"
  end

  private

  def set_product
    @product = current_user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :stock, :price, :expiration_date)
  end
end
