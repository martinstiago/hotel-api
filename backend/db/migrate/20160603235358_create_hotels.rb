class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :star_rating

      t.timestamps
    end
  end
end
