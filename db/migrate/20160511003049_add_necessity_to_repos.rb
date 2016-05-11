class AddNecessityToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :necessity, :text
  end
end
