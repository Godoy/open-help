class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :full_name
      t.string :github_id
      t.string :github_html_url
      t.string :github_description
      t.string :github_homepage
      t.string :github_ssh_url
      t.string :github_language
      t.string :github_open_issues
      t.string :github_forks
      t.string :github_stargazers_count

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
