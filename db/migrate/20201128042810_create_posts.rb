class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer    :number, null: false
      t.string     :title,  null: false, default: ""
      t.text       :text,   null: false
      t.boolean    :mark,   null: false, default: "false"
      t.references :user,   foreign_key: true
      t.timestamps
    end
  end
end
