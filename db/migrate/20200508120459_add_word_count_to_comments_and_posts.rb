class AddWordCountToCommentsAndPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :word_count, :integer
    add_column :comments, :word_count, :integer
  end
end
