class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  attr_accessor :login

  has_many :approvals
  has_many :matches, through: :approvals


  def new_partner
    User.where.not(id: previous_partner_ids).sample
  end

  def previous_partner_ids
    matches.map { |m| m.approvals.pluck(:user_id) }.uniq!
  end

  def profile_completed?
    !!code_sample
  end

  def email_required?
    false
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
