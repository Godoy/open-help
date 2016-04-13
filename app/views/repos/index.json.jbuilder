json.array!(@repos) do |repo|
  json.extract! repo, :id, :name, :full_name, :github_id, :github_html_url, :github_description, :github_homepage, :github_ssh_url, :github_language, :github_open_issues, :github_forks, :github_stargazers_count
  json.url repo_url(repo, format: :json)
end
