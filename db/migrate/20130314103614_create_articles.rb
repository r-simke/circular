class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :topic
      t.text :content
      t.references :newsletter
      t.references :antecessor
      t.boolean :show_dividerline

      t.timestamps
    end
    add_index :articles, :newsletter_id
    add_index :articles, :antecessor_id
  end
end
