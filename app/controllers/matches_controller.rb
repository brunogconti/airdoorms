class MatchesController < ApplicationController
  def index
    @matches = policy_scope(Match)
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
      redirect_to room_path(@match)
    else
      render :new
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
end
