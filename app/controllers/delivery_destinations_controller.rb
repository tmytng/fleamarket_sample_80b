class DeliveryDestinationsController < ApplicationController
    def new
        @delivery_destination = Delivery_destination.new
    end

    def create
        @delivery_destination = Delivery_destination.new(delivery_destination_params)
        if @delivery_destination.save
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def delivery_destination_params
        params.require(:delivery_destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :prefecture, :city, :address, :phone_number)
        # 複数テーブルの情報を一つのフォームから送る時↓
        # params.require(:user).permit(:nickname, :user_image, :profile, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day, delivery_destination_attributes:[:post_code, :prefecture, :city, :address, :building_name, :phone_number])
    end
end