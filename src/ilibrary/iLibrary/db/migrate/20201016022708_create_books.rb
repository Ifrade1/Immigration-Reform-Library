class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      #books will have a title, description author and links attached to them. 
      t.string :title
      t.text :description
      t.string :author
      t.string :links
      t.timestamps null: false
    end
  end
end
