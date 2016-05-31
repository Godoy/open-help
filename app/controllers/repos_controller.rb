class ReposController < ApplicationController
  before_action :set_repo, only: [:show, :update, :remove]
  before_action :authenticate_user!

  # GET /repos
  # GET /repos.json
  def index
    @repos = Repo.by_programming_language(params["programming_language"])
            .by_language(params["language"])
            .paginate(:page => params[:page], :per_page => 20)

    @programming_languages = Repo.uniq.pluck(:github_programming_language)
    @languages = Repo.where.not(language: [nil, '']).uniq.pluck(:language)
    @user_repos = Octokit.repositories current_user.nickname
    @orgs = Octokit.orgs current_user.nickname

  end

  def github_repos
    @user_repos = Octokit.repositories current_user.nickname
    @orgs = Octokit.orgs current_user.nickname
    @registered_repos = current_user.repos.pluck(:github_id)
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
  end

  # GET /repos/new
  def new
    @github_repo = Octokit.repository(params[:github_id].to_i)

    # logger.debug @github_repo.to_yaml
    @repo = Repo.new(github_id: params[:github_id])

    @programming_languages = Octokit.languages(params[:github_id].to_i)
    @common_languages = LanguageList::COMMON_LANGUAGES
  end

  # GET /repos/1/edit
  def edit
    @github_repo = Octokit.repository(params[:id].to_i)
    @repo = Repo.find_by_github_id(params[:id])

    @programming_languages = Octokit.languages(params[:id].to_i)
    @common_languages = LanguageList::COMMON_LANGUAGES
  end

  # POST /repos
  # POST /repos.json
  def create
    @github_repo = Octokit.repository(repo_params[:github_id].to_i)
    @repo = Repo.new(repo_params)

    @repo.attributes = {
      name: @github_repo.name,
      full_name: @github_repo.full_name,
      github_id: @github_repo.id,
      github_html_url: @github_repo.html_url,
      github_description: @github_repo.description,
      github_homepage: @github_repo.homepage,
      github_ssh_url: @github_repo.ssh_url,
      github_open_issues: @github_repo.open_issues,
      github_forks: @github_repo.forks,
      github_stargazers_count: @github_repo.stargazers_count,
      user: current_user
    }

    respond_to do |format|
      if @repo.save
        format.html { redirect_to @repo, notice: 'Repo was successfully created.' }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :new }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { render :show, status: :ok, location: @repo }
      else
        format.html { render :edit }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    @repo.active = false

    respond_to do |format|
      if @repo.save
        format.html { redirect_to github_repos_path, notice: 'Repo was successfully removed.' }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :edit }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_repo
    @repo = Repo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def repo_params
    params.require(:repo).permit(:github_id, :github_programming_language, :language, :necessity)
  end
end
