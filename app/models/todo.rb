class Todo < ApplicationRecord
  validates_presence_of :title

  def self.by_checked checked=false
    if checked
      where.not(checked_at: nil)
    else
      where(checked_at: nil)
    end
  end

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
