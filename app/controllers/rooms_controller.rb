class RoomsController < ApplicationController


  def new
    @room = Room.new
    @rooms = Room.all
    @users = User.all
  end

  def create
    @users = User.all
    @rooms = Room.all
    # binding.pry
    @room = Room.new(room_params)
    if @room.save!
      redirect_to new_room_path
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
end
