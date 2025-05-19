class AddAddressToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :zip_code, :string
    add_column :users, :address, :text
  end
end
