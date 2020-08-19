class ProductsController < ApplicationController
  
    before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
    before_action :set_product, only: [:show, :edit, :update, :destroy, :purchase, :buy]

    def index
        @products = Product.all.order("id DESC").limit(10)

        @products = Product.includes(:product_imgs).order('created_at DESC')

    end

    def new
        @product = Product.new

        @product.product_imgs.build

        @parent = Category.where(id: 1..13)
        
    end

    def create
        @product = Product.new(product_params)
        # binding.pry
        if @product.save
            params[:product_img][:image].each do |image|
                @product.photos.create(image: image, product_id: @product.id)
            end
            redirect_to root_path
        else
            redirect_to new_product_path
        end
    end

    def show
    end

    def destroy
        if @product.destroy
            redirect_to root_path
        else
            redirect_to product_path(@product.id)
        end
    end


private

    #jsonで親の名前で検索し、紐づく子カテゴリーの配列を取得
    def get_category_children
        @category_children = Category.find(params[:parent_id]).children
    end

    #jsonで子カテゴリーに紐づく孫カテゴリーの配列を取得
    def get_category_grandchildren
        @category_grandchildren = Category.find(params[:child_id]).children
    end

    # private
    #親カテゴリー
    def set_category  
        @category_parent_array = Category.where(ancestry: nil)
    end

    def product_params
        params.require(:product)
            .permit(:name, :price, :description, :condition,
                :size, :shipping_cost, :shipping_days,
                :prefecture, :trading_status,
                :category_id,
                product_imgs_attributes: [:image, :id],
                brands_attributes: [:name, :id]
            )
            .merge(user_id: current_user.id)
    end


    def set_product
        @product = Product.find(params[:id])
    end

end
