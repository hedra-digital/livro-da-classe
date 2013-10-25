# encoding: utf-8

class ProjectValidator < ActiveModel::Validator
  def validate(record)
    if record.release_date.present? and record.release_date_changed?
      if record.has_valid_release_date?
        return true
      else
        record.errors.add(:release_date, :invalid_release_date, :manufacture_time => Project::MANUFACTURE_IN_UNITS)
      end
    else
      return true
    end
  end
end
