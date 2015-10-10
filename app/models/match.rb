class Match < ActiveRecord::Base
  has_many :approvals
  has_many :users, through: :approvals

  enum status: [:pending, :made, :avoided, :engaged]


  def self.matchmake(user)
    new_partner = user.new_partner
    pending_matches = user.matches.where(status: "pending")

    if pending_matches.any?
      pending_matches.sample
    elsif new_partner
      match = create
      match.approvals.create(user_id: user.id)
      match.approvals.create(user_id: new_partner.id)
    else
    end
  end

  def partner_for(user)
    (users - [user]).first
  end

  def approval_for(user)
    approvals.where(user: user).first
  end

end
