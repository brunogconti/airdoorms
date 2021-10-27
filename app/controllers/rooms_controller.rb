class RoomsController < ApplicationController

  def new
    @room = Room.new
    authorize @room
  end

  def create
    @room = Room.new(room_params)
    authorize @room
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
