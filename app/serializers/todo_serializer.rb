class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :checked

  def checked
    object.checked_at.present?
  end
end
