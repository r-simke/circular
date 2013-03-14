class CreateSidearticles < ActiveRecord::Migration
  def change
    create_table :sidearticles do |t|
      t.string :topic
      t.text :content
      t.references :newsletter
      t.integer :position

      t.timestamps
    end
    add_index :sidearticles, :newsletter_id
  end
end
