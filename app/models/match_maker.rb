class MatchMaker
  def initialize(user)
    @user = user
    @previous_partners = User.where(id: @user.matches.map { |m| m.approvals.pluck(:user_id) }.flatten.compact)
    @all_pending_matches = @user.matches.where(status: "pending")
    @already_decided_matches = Match.where(id: @user.approvals.where.not(given: nil).pluck(:match_id))

    @potential_partners = User.all - @previous_partners - [user]
    @pending_matches = (@all_pending_matches - @already_decided_matches).uniq
  end

  def matchmake
    return @pending_matches.sample if @pending_matches.any?
    return create_new_potential_match(@potential_partners.sample) if @potential_partners.any?
    EmptyMatch.new
  end

  def create_new_potential_match(partner)
    @match = Match.create
    @match.approvals.create(user: @user)
    @match.approvals.create(user: partner)
    @match
  end

  class EmptyMatch
    def status
      "nothing"
    end

    def partner_for(arg)
      nil
    end

    def approval_for(arg)
      nil
    end
  end
end
