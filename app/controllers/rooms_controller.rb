class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:keyword].present?
      @keyword = params[:keyword]
      @rooms = policy_scope(Room).where("title iLIKE ?", "%#{params[:keyword]}%")
    else
      @rooms = policy_scope(Room)
    end
    @markers = @rooms.geocoded.map do |room|
      {
        lat: room.latitude,
        lng: room.longitude
      }
    end
  end

  def show
    @room = Room.find(params[:id])
    @match = Match.new
    @match = Match.new(room: @room_id)
    authorize @room
  end

  def new
    @room = Room.new
    authorize @room
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    authorize @room
    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
    authorize @room
  end

  def update
    @room = Room.find(params[:id])
    authorize @room
    if @room.update(room_params)
      redirect_to room_path, notice: 'room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize @room
    @room.destroy
    redirect_to rooms_url, notice: 'room was successfully destroyed.'
  end

  private

  def room_params
    params.require(:room).permit(:title, :description, :address, :room_type, :value)
  end
end
