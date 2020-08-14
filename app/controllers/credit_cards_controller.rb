class CreditCardsController < ApplicationController
  
  require "payjp"

  def new
    @card = CreditCard.new
    # card = CreditCard.where(user_id: current_user.id)
    # redirect_to action: "show" if card.exists?
  end

  def create #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = "PAYJP_PRIVATE_KEY"
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "new"
      else
        redirect_to action: "new"
      end
    end
  end

  def pay
    product = Product.find(credit_card_params[:product_id])
    card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = 'PAYJP_PRIVATE_KEY'
    Payjp::Charge.create(
    amount:  product.price,
    customer: card.customer_id,
    currency: 'jpy',
    )
    product[:status] = 1
    product.save
   redirect_to action: 'complete'
  end

  def delete #PayjpとCardデータベースを削除します
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = "PAYJP_PRIVATE_KEY"
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します（キータのindexも兼ねてる,参照のconfimation）
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = "PAYJP_PRIVATE_KEY"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end