class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match
  before_action :set_partner
  before_action :set_approval
  skip_before_action :set_partner, :set_approval if :no_match?

  def show
  end

  private
    def set_match
      if params[:id].present?
        @match = Match.find(params[:id])
      else
        @match = MatchMaker.new(current_user).matchmake
      end
    end

    def set_partner
      @partner = @match.partner_for(current_user)
    end

    def set_approval
      @approval = @match.approval_for(current_user)
    end

    def no_match?
      @match.class == "Match"
    end
end
