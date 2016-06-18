class AddInitialCoverToBook < ActiveRecord::Migration
  def change
    add_attachment :books, :initial_cover
  end
end
