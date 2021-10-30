class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:keyword].present?
      @rooms = policy_scope(Room).where("title ILIKE ?", "%#{params[:keyword]}%")
    else
      @rooms = policy_scope(Room)
    end
    @markers = @rooms.geocoded.map do |room|
      {
        lat: room.latitude,
        lng: room.longitude,
        info_window: render_to_string(partial: "info_window", locals: { room: room }),
        image_url: helpers.asset_url('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn2.iconfinder.com%2Fdata%2Ficons%2Fmap-pins-1-01-easylines%2F128%2Fyumminky-pin-87-512.png&f=1&nofb=1')
      }
    end
  end

  def show
    @room = Room.find(params[:id])
    @match = Match.new
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
      redirect_to room_path(@room), notice: 'room was successfully updated.'
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
