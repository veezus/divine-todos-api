class Todo < ApplicationRecord
  validates_presence_of :title

  def check!
    return if checked?
    update_attribute :checked_at, DateTime.now
  end

  def uncheck!
    return unless checked?
    update_attribute :checked_at, nil
  end

  def checked
    checked_at.present?
  end
  alias checked? checked
end
