module RepoHelper
  def link_add_or_edit_repo(repo)
    if @registered_repos.include? repo.id.to_s
      render "repos/link_edit", repo: repo
    else
      render "repos/link_add", repo: repo
    end
  end
end
