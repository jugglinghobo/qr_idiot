class AddImageToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :image_url, :string
  end

  def down
    remove_column :posts, :image_url
  end
end
