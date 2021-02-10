class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
