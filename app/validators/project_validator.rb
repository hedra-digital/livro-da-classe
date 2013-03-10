# encoding: utf-8

class ProjectValidator < ActiveModel::Validator
  def validate(record)
    if record.release_date.present? 
      if record.has_valid_release_date?
        return true
      else
        record.errors[:release_date] << "Data de lançamento precisa ser pelo menos daqui a #{Project::MANUFACTURE_IN_UNITS} semanas"
      end
    else
      return true
    end
  end
end
