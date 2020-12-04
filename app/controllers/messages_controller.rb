class MessagesController < ApplicationController
  def index
    @users = User.all
    @room = Room.find(params[:room_id])
    @message = Message.new
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @messages.save
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
