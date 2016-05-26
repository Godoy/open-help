class AddActiveToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :active, :boolean, default: true
  end
end
