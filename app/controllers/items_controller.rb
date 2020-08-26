class ItemsController < ApplicationController

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

  def show
    @category = Category.find(params[:id])
  end

end
