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

  def edit
    @room = Room.find(params[:room])
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: 'room was successfully destroyed.'
  end

  private


  def room_params
    params.require(:room).permit(:title, :description, :address, :room_type, :value)
  end
end
