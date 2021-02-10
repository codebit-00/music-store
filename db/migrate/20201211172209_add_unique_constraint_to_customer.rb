class AddUniqueConstraintToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_index :customers, :username, unique: true
    add_index :customers, :email, unique: true
  end
end
