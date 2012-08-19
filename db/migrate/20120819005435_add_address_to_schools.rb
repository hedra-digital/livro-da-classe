class AddAddressToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :address_1, :string
    add_column :schools, :address_2, :string
    add_column :schools, :city, :string
    add_column :schools, :state, :string
    add_column :schools, :postal_code, :string
  end
end