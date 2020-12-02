class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @board = Board.create(board_params)
    if @board.save
      redirect_to root_path
    else
      render :index
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if current_user.authority == true
      @board.destroy
      redirect_to root_path
    else
      render :index
    end
  end


  private
  def board_params
    params.require(:board).permit(:text).merge(user_id: current_user.id)
  end
end
