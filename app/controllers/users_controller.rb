class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @nickname = current_user.nickname
    @products = current_user.products
    @delivery = current_user.delivery_destination
    unless user_signed_in? && @user.id == current_user.id
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :user_image, :profile, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day)
  end

end
