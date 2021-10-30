class MatchesController < ApplicationController
  def index
    @matches = policy_scope(Match)
    @title = "My reservations"
  end

  def show
    @match = Match.find(params[:id])
    authorize @match
  end

  def create
    @match = Match.new(match_params)
    @match.user = current_user
    authorize @match
    if @match.save
      redirect_to match_path(@match)
    else
      render 'rooms/show'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    authorize @match
    @match.destroy
    redirect_to matches_url, notice: 'match was successfully destroyed.'
  end

  private

  def match_params
    params.require(:match).permit(:start_date, :end_date, :price, :room_id, :user_id)
  end
end
