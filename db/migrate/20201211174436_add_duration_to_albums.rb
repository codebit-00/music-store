class AddDurationToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :duration, :integer
  end
end
