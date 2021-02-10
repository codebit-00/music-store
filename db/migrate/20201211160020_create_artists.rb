class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :nationality
      t.date :birth_date
      t.date :death_date

      t.timestamps
    end
  end
end
