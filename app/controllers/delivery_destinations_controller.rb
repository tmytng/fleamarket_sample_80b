class DeliveryDestinationsController < ApplicationController
    
    before_action :set_delivery, only: [:edit,:update]
    
    def new
        @delivery_destination = DeliveryDestination.new
    end

    def create
        @delivery_destination = DeliveryDestination.new(delivery_destination_params)
        if @delivery_destination.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        unless user_signed_in? && @delivery.user_id == current_user.id
            redirect_to root_path
        else
            render :edit
        end
    end

    def update
        if @delivery.user_id == current_user.id && @delivery.update(delivery_destination_params)
            flash[:notice] = "更新が完了しました。"
            redirect_to root_path
        else
            render :edit
        end
    end

    private

    def delivery_destination_params
        params.require(:delivery_destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :prefecture, :city, :address, :buiding_name, :phone_number).merge(user_id: current_user.id)
    end

    def set_delivery
        @delivery = DeliveryDestination.find(params[:id])
    end
end
