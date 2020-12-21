class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @boards = Board.all
    @board = Board.new
    @plans = Plan.all
    @plan = Plan.new
  end


  def show
    @user = User.find(params[:id])
    @shop = Shop.last
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :image)
  end

end
