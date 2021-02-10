class DateNotFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if value.nil?

    record.errors.add attribute, "Date can't be in the future" if Time.zone.today < value
  end
end

class Artist < ApplicationRecord
  validates :name, presence: true
  validates :birth_date, presence: false, date_not_future: true
  validates :death_date, presence: false
  validate :validate_death_date_after_birth_date

  def validate_death_date_after_birth_date
    return true unless birth_date && death_date

    errors.add(:death_date, 'is invalid') if death_date < birth_date
  end
end
