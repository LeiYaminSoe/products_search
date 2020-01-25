# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

records = JSON.parse(File.read(Rails.root.join('db', 'SpocketProducts.json')))
records.each do |record|
  product = Product.new(title: record['title'], description: record['description'], price: record['price'], country: record['country'])
  proc_tags = record['tags'].split(",").map(&:strip)
  proc_tags.each do |tag|
    uniq_tag = Tag.where(name: tag).first_or_create do |new_tag|
      new_tag.name = tag
    end
    product.tags << uniq_tag
  end
  product.save
end
