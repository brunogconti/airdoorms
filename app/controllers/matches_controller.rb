class MatchesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @maches = policy_scope(Match)
  end

  def show
    authorize @match
    @room = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:start_date, :end_date, :price, :room_id, :user_id)
  end
end
