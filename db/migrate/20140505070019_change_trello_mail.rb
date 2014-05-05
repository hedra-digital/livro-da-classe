class ChangeTrelloMail < ActiveRecord::Migration
  def up
    publisher = Publisher.find_by_name("Editora Hedra")
    if publisher
      publisher.trello_email = "andylin17+stctgwh8rbg2y23zoitw@boards.trello.com"
      publisher.save
    end
  end

  def down
  end
end
