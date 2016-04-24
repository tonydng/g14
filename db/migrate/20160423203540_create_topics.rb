class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name

      t.timestamps null: false
    end
  end
end
