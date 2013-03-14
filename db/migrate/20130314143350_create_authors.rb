class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :title
      t.string :phone
      t.string :email
      t.string :image_url

      t.timestamps
    end
  end
end
