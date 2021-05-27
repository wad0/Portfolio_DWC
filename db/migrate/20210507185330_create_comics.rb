class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.integer :user_id
      t.string :title
      t.text :memo
      t.boolean :complete, default: true
      t.float :evaluation

      t.timestamps
    end
  end
end
