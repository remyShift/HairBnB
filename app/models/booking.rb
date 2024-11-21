class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :wig

  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :end_time_after_start_time
  validate :end_time_not_same_day_as_start_time

  private

  def end_time_after_start_time
    if end_time.present? && start_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def end_time_not_same_day_as_start_time
    if end_time.present? && start_time.present? && end_time.to_date == start_time.to_date
      errors.add(:end_time, "must be at least one day after start time")
    end
  end
end
