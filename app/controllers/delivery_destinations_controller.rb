class DeliveryDestinationsController < ApplicationController
    def new
        @delivery_destination = DeliveryDestination.new
    end

    def create
        @delivery_destination = DeliveryDestination.new(delivery_destination_params)
        if @delivery_destination.save
            flash[:notice] = "登録が完了しました。"
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @delivery = DeliveryDestination.find(params[:id])
    end

    def update
        @delivery = DeliveryDestination.find(params[:id])
        @delivery.update(delivery_destination_params)
        flash[:notice] = "更新が完了しました。"
        redirect_to root_path
    end

    private

    def delivery_destination_params
        params.require(:delivery_destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :prefecture, :city, :address, :buiding_name, :phone_number).merge(user_id: current_user.id)
        # 複数テーブルの情報を一つのフォームから送る時↓
        # params.require(:user).permit(:nickname, :user_image, :profile, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day, delivery_destination_attributes:[:post_code, :prefecture, :city, :address, :building_name, :phone_number])
    end
end
