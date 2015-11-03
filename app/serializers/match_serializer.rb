class MatchSerializer < ActiveModel::Serializer
  attributes :id
  has_many :chats
end
