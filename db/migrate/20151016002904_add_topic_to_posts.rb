#"Add" [table whose id we want to add] + "To" [table we wnat to add the foreign key to]
class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer
    add_index :posts, :topic_id
  end
end
