class Match < ActiveRecord::Base
  has_many :approvals
  has_many :users, through: :approvals

  enum status: [:pending, :made, :avoided, :engaged]

  def self.pending_for_user(user)
    already_decided_matches = where(id: user.approvals.where.not(given: nil).pluck(:match_id) )
    where(status: "pending") - already_decided_matches
  end

  def self.matchmake(user)
    # list of pending matches by user
    # list of matches user's already decided
    # list of potential partners

    pending_matches = user.matches.where(status: "pending")

    new_partner = user.new_partner
    pending_matches = pending_for_user(user)

    if pending_matches.any?
      pending_matches.sample
      failure
    elsif new_partner
      match = create
      match.approvals.create(user_id: user.id)
      match.approvals.create(user_id: new_partner.id)
    else
      nil
    end
  end

  def partner_for(user)
    (users - [user]).first
  end

  def approval_for(user)
    approvals.where(user: user).first
  end
end
