class AddPolymorphicReferenceToComments < ActiveRecord::Migration[5.0]
  def up
    add_reference :comments, :opinion, polymorphic: true
    remove_reference :comments, :post
    remove_reference :comments, :user
  end

  def down
    remove_reference :comments, :opinion
    add_reference :comments, :post
    add_reference :comments, :user
  end

end
