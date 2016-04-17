class CreateBookTopics < ActiveRecord::Migration
  def change
    create_table :book_topics do |t|
      t.references :book, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
