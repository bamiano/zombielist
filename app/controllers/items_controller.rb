class ItemsController < ApplicationController
	before_action :find_item, only: [:destroy]
  before_action :current_user
  before_action :confirm_logged_in

  def index
    @items = User.find(current_user).items
  end 

  def new
    @item = Item.new
  end

  def create
    current_user.items << Item.find(item_id)
  end

  def favorite
    favorite = Item.find(params[:item_id])
    if ItemsUser.where(user_id: @current_user, item_id: favorite.id).empty?
      @current_user.items << favorite 
    end
    redirect_to items_path
  end

  def destroy
    item = Item.find(params[:id])
    user = item.users.find(current_user.id)
    if item and user
        item.users.delete(user)
    end
    redirect_to items_path
  end


  private
  def items_params
    params.require(:item).permit(:item, :url, :image, :price, :description)
  end

  def find_item
     item = Item.find(params[:id])
  end





end