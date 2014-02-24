class AddCapaToBookDatas < ActiveRecord::Migration
  def self.up
    add_attachment :book_datas, :capainteira
  end

  def self.down
    remove_attachment :book_datas, :capainteira
  end
end
