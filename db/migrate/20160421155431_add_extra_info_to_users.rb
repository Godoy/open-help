class AddExtraInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followers, :integer, default: 0
    add_column :users, :public_repos, :integer, default: 0
  end
end
