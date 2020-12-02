class UsersController < ApplicationController
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

  def board_params
    params.require(:board).permit(:text).merge(user_id: current_user.id)
  end
end
