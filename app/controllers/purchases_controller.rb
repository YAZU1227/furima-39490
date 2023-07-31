class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_public_key, only: [:index, :create]
  before_action :find_item, only: [:index, :create]


  def index
    @purchase_shipping = PurchaseShipping.new
  
    if @item.sold? || @item.user == current_user
      redirect_to root_path
      return
    end
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
  
    if @item.sold? || @item.user == current_user
      redirect_to root_path
      return
    elsif @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    item = Item.find(params[:item_id])
    params.require(:purchase_shipping).permit(:post_code, :prefecture_id, :city, :address, :building, :telephone_number)
          .merge(user_id: current_user.id, item_id: item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end
