class Match < ActiveRecord::Base
  include ActiveModel::Serialization

  has_many :approvals
  has_many :users, through: :approvals
  has_many :chats

  enum status: [:pending, :made, :avoided, :engaged]

  def partner_for(user)
    (users - [user]).first
  end

  def approval_for(user)
    approvals.where(user: user).first
  end

  def update_status!
    decision = approvals.pluck(:given)
    if decision == [true, true]
      made!
    elsif decision.include?(nil)
      pending!
    elsif decision.include(false)
      avoided!
    elsif chats.any?
      engaged!
    else
      raise InappropropriateStatusException
    end
  end
end
