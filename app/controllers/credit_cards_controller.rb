class CreditCardsController < ApplicationController
  
  require "payjp"

  def new
    @card = CreditCard.new
    # card = CreditCard.where(user_id: current_user.id)
    # redirect_to action: "show" if card.exists?
  end


  def create #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
    customer = Payjp::Customer.create(
    card: params['payjp-token'],
    metadata: {user_id: current_user.id}
    ) #念の為metadataにuser_idを入れましたがなくてもOK
    @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        redirect_to action: "new"
      end
    end
  end
  

  def show
    @product = Product.find(params[:id])
    card = CreditCard.find_by(user_id: current_user.id)
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to action: "new"
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end


  def pay
    @product = Product.find(params[:id])
    card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount:  @product.price,
    customer: card.customer_id,
    currency: 'jpy',
    )
    product[:trading_status] = 1
    product.save
  redirect_to action: 'done'
  end


  def done
    @product = Product.find(params[:id])
  end


  def index 
    card = CreditCard.find_by(user_id: current_user.id)
    @card = card.id
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
  

  def delete #PayjpとCardデータベースを削除します
    card = CreditCard.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end


  private
  def credit_card_params
    params.permit('payjp-token',:product_id)
  end

  
end