class ChatSerializer < ActiveModel::Serializer
  attributes :id, :message, :name

  def name
    object.user.username
  end
end
