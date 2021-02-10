class AddBiographyToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :biography, :string
  end
end
