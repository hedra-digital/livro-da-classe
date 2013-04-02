# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Data

templates = [
  {
    :name => "Template padrão"
  }
]

# Database operations

templates.each do |attributes|
  Template.find_or_initialize_by_name(attributes[:name]).tap do |t|
    t.save!
  end
end
