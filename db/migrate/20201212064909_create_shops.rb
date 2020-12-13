class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string  :name,         null: false
      t.integer :postal_code,  null: false
      t.string  :address,      null: false
      t.string  :phone_number, null: false
      t.text    :text
      t.timestamps
    end
  end
end
