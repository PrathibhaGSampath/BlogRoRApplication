class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :title, limit: 50
      t.text :body, limit: 200
      t.string :status
      t.references :user, dependency: :destroy
      t.timestamps
    end
  end
end
