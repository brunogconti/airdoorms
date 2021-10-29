class MatchesController < ApplicationController
  def index
    @matches = policy_scope(Match)
    @title = "My reservations"
		# @reservations = current_user.reservations
  end

  def show
    @match = Match.find(params[:id])
    authorize @match
  end

  def create
    @match = Match.new(match_params)
    @match.user = current_user
    #@room = Room.find(params[:room_id])
    #@match.room = @room
    authorize @match
    if @match.save
      redirect_to matches_path
    else
      # render 'rooms/show'
      redirect_to rooms_url, notice: 'Tivemos problemas em concluir a requisição'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    authorize @match
    @match.destroy
    redirect_to matches_url, notice: 'match was successfully destroyed.'
  end

  def match_params
    params.require(:match).permit(:start_date, :end_date, :price, :room_id, :user_id)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
