class ProductsController < ApplicationController
    def index
        @products = Product.all.order("id DESC").limit(10)
        @products = Product.includes(:images).order('created_at DESC')
    end

    def new
        @product = Product.new
        # @product.images.build()
        @parent = Category.where(id: 1..13)
    end

    def create
        @product = Product.new(product_params)

        # if @product.save
            # params[:product_images][:image].each do |image|
            #     @product.photos.create(image: image, product_id: @product.id)
            # 途中なのであしからず
        #     end
        #     redirect_to root_path
        # else
        #     redirect_to new_product_path
        # end
    end

    def show
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:name, :price, :description, :condition, :size, :shipping_cost, :shipping_days, :prefecture, :trading_status)
    end

end
