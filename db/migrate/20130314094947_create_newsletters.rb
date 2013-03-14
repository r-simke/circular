class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :topic
      t.text :content
      t.integer :author_id
      t.integer :template_id
      t.integer :status_id
      t.boolean :show_outline
      t.text :code
      t.boolean :show_dividerline

      t.timestamps
    end
  end
end
