module UserHelper
  def user_resume(user)
    content = "<a href='https://github.com/#{user.nickname}' target='_blank'>#{user.name}</a> "

    content += "<span class='label label-info' title='Followers'>" +
    "<span class='glyphicon glyphicon-user' aria-hidden='true'></span> " +
    "#{user.followers}" +
    "</span>"

    content += "<span class='label label-warning' title='Repositories'>" +
    "<span class='glyphicon glyphicon-hdd' aria-hidden='true'></span> " +
    "#{user.public_repos}" +
    "</span>"

    content.html_safe
  end
end
