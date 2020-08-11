class ProductsController < ApplicationController
    def index
        @products = Product.all.order("id DESC").limit(10)
    end

    def new
        @product = Product.new
        @product.images.build
        @parent = Category.where(id: 1..13)
    end
end
