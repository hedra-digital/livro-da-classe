class Scrap < ActiveRecord::Base
  attr_accessible :book_id, :content, :is_admin, :admin_name, :parent_scrap_id, :answered

  belongs_to :book

  def childs
  	Scrap.where(:parent_scrap_id => self.id).order('created_at ASC').all
  end

end
