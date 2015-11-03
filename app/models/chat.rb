class Chat < ActiveRecord::Base
  include ActiveModel::Serialization

  belongs_to :match
  belongs_to :user
end
