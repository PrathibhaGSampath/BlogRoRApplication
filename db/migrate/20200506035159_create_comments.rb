class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :description, limit: 100
      t.references :post, dependency: :destroy
      t.references :user, dependency: :destroy
      t.timestamps
    end
  end
end
