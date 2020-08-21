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
    @products =  Product.where(category_id: [159..356]).order(created_at: :desc).limit(5)
    @brands =  Brand.where(name:"agete").order(created_at: :desc).limit(5)
  end


  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end

# home.controller.rbへ改称予定
