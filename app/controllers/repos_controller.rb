class ReposController < ApplicationController
  before_action :set_repo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /repos
  # GET /repos.json
  def index
    @repos = Repo.all
    @repositories = Octokit.repositories current_user.nickname
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
  end

  # GET /repos/new
  def new
    github_repo = Octokit.repository(params[:github_id].to_i)
    @repo = Repo.new(github_id: params[:github_id], name: github_repo.name)

  end

  # GET /repos/1/edit
  def edit
  end

  # POST /repos
  # POST /repos.json
  def create
    @repo = Repo.new(repo_params)

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

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo.destroy
    respond_to do |format|
      format.html { redirect_to repos_url, notice: 'Repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:name, :full_name, :github_id, :github_html_url, :github_description, :github_homepage, :github_ssh_url, :github_language, :github_open_issues, :github_forks, :github_stargazers_count)
    end
end
