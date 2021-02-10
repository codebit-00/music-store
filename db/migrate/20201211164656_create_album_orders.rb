class CreateAlbumOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :album_orders do |t|
      t.integer :total_copies
      t.references :album, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
