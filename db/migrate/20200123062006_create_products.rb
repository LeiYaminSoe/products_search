class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price, :default => 0      
      t.string :origin_country
      t.timestamps
    end
  end
end
