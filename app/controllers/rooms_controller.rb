class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @rooms = policy_scope(Room)
    #authorize não funcionou 
  end

  def show
    authorize @room
    @room = Room.find(params[:id])
  end

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
