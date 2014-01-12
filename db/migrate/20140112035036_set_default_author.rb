class SetDefaultAuthor < ActiveRecord::Migration
  def up
    change_column :posts, :author, :string, :default => "anonym"
  end

  def down
    change_column :posts, :author, :string, :default => nil
  end
end
