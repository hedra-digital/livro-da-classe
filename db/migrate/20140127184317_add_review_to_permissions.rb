class AddReviewToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :review, :boolean, :default => false
  end
end
