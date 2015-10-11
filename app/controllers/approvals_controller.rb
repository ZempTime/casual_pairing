class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match
  before_action :set_approval
  after_action :update_match_status

  def update
    if @approval.update approval_params
      redirect_to browse_path
    else
      redirect_to browse_path, notice: "Didn't work! Oh f!"
    end
  end

  private
    def approval_params
      params.require(:approval).permit(:given)
    end
    def set_match
      @match = current_user.matches.find(params[:match_id])
    end

    def set_approval
      @approval = @match.approvals.find(params[:id])
    end

    def update_match_status
      @match.update_status!
    end
end
