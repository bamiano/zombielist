class ItemsController < ApplicationController
	def index
		@items = Item.all
	end
  # need new action

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(items_params)
    if @item.save
      flash[:success] = "Item created and saved"
      redirect_to items_path
    else
      render :new
    end
  end

  private
  def items_params
    params.require(:item).permit(:item, :url, :image, :price, :description)
  end

end
