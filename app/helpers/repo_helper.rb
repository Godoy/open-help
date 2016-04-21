module RepoHelper
  def repo_counters(repo)
    content = "<span class='label label-warning' title='Stars'>" +
              "<span class='glyphicon glyphicon-star' aria-hidden='true'></span> " +
              "#{repo.github_stargazers_count}" +
              "</span>" if repo.github_stargazers_count.present?

    content += "<span class='label label-info' title='Forks'>" +
              "<span class='glyphicon glyphicon-transfer' aria-hidden='true'></span> " +
              "#{repo.github_forks}" +
              "</span>" if repo.github_forks.present?

    content += "<span class='label label-danger' title='Issues'>" +
              "<span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span> " +
              "#{repo.github_open_issues}" +
              "</span>" if repo.github_open_issues.present?

    content.html_safe
  end
end
