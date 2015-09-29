class Purchases::ProductsController < ApplicationController
  before_action :redirect_to_new_session
  before_action :find_product, only:[:update, :destroy]
  before_action :product, only:[:new, :create]

  layout false

  def index
    @products = current_company.products.order('products.created_at DESC')
  end

  def create
    @product.update(product_params)
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.json { head :no_content }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
  end

  private

  def product_params
    params.require(:product).permit!
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def product
    @product = current_company.products.new(number: current_company.products.count + 1)
  end
end
