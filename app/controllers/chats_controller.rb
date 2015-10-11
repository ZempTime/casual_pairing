class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match

  def create
    @chat = @match.chats.new chat_params
    @chat.user = current_user

    if @chat.save
      redirect_to match_path(@match)
      @match.engaged! unless @match.engaged?
    else
      redirect_to match_path(@match), notice: "Your message couldn't be posted"
    end
  end

  private
    def set_match
      @match = current_user.matches.find(params[:match_id])
    end

    def chat_params
      params.require(:chat).permit(:match_id, :user_id, :message)
    end
end
