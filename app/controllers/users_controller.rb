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
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :image)
  end

end
