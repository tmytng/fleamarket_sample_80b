class ItemsController < ApplicationController

  def new
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def index
    @products =  Product.order(created_at: :desc).limit(5)
    @brands =  Brand.where(name:"フリマ").order(created_at: :desc).limit(5)
  end

  def show
    @category = Category.find(params[:id])
  end

end
