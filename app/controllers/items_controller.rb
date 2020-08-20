class ItemsController < ApplicationController
  before_action :set_parents

  def new
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def index
    # @products = Product.order(created_at: :desc).limit(5)
    @products =  Product.where(category_id: [159..356]).order(created_at: :desc).limit(5)
    # @products = Category.all.order(created_at: :desc).limit(5)
    # @product_imgs = ProductImg.find(1)
    # https://s3-ap-northeast-1.amazonaws.com/fleamarket80b/uploads/product_img/image/1/yumekawa_animal_usagi.png
  end


  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end

# home.controller.rbへ改称予定
