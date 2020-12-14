class ShopsController < ApplicationController
  before_action :find_shop, only: [:edit, :update]
  before_action :move_to_index, only: [:new, :edit]

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.create(shop_params)
    if  @shop.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end 

  def update
    if @shop.update(shop_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
  end 

  private

  def shop_params
    params.require(:shop).permit(:name, :postal_code, :address, :phone_number, :text, :image)
  end

  def find_shop
    @shop = Shop.last
  end

  def move_to_index
    redirect_to root_path if current_user.authority == false 
  end

end
