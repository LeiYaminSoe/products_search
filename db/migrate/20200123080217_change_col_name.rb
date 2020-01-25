class ChangeColName < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :origin_country, :country
  end
end
