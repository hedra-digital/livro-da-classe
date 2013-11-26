# encoding: UTF-8

class Publisher < ActiveRecord::Base

  attr_accessible               :name, :url, :logo, :official_name, :address, :district, :city, :uf, :telephone

  has_attached_file :logo,
                    :styles => {
                      :normal => ["600x600>", :png],
                      :small => ["300x300#", :png]
                    }

end