class RoomsController < ApplicationController

  def new
    authorize @room
    @room = Room.new
  end

  def create
    authorize @room
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  def room_params
    params.require(:room).permit(:title, :description, :address, :room_type, :value)
  end
end
