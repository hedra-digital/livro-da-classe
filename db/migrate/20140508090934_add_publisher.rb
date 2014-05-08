class AddPublisher < ActiveRecord::Migration
  def up
    Profile.create(:desc => "Publisher")
  end

  def down
  end
end
