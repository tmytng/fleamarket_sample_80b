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

  private

  def user_params
    params.require(:user).permit(:nickname, :user_image, :profile, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day)
    # 複数テーブルの情報を一つのフォームから送る時↓
    # params.require(:user).permit(:nickname, :user_image, :profile, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day, delivery_destination_attributes:[:post_code, :prefecture, :city, :address, :building_name, :phone_number])
  end

end
