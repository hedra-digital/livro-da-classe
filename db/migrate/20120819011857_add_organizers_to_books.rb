class AddOrganizersToBooks < ActiveRecord::Migration
  def change
    add_column :books, :organizers, :string
    add_column :books, :directors, :string
    add_column :books, :coordinators, :string
    add_column :books, :subtitle, :string
  end
end
