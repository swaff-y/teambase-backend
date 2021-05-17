class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user

  # GET /projects or /projects.json
  def index
    @projects = Project.all

    headers['Access-Control-Allow-Origin'] = '*'
    respond_to do |format|
      format.html { render index: @projects = Project.all  }
      format.json { render json: Project.all , include: ['tasks','users'] }
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def user_projects
    projects = User.find_by(id: params[:user]).projects
    render json: projects, include: ['tasks']
  end
  def user_project
    project = Project.find_by(id: params[:project_id])
    render json: project,
    include: {
      tasks: {
        users: { only: [:name]}
      }
    }
  end
  def user_project_status
    project = Project.find_by(id: params[:project_id]).tasks.where(status: params[:status])
    render json: project, include: ['users']
  end

  def project_priority_update
    project = Project.find(params[:project_id])

    project.update(
      priority: params[:priority]
    )
  end

  def create_project
    project = Project.create(
      name: params[:name],
      due_date: params[:due_date],
      status: params[:status],
      progress: params[:progress],
      category: params[:category],
      description: params[:description]
    )

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      project.users << user
    end
    ProjectCategory.find_by(id: params[:category]).projects << project

    render json: project, include: ['users','project_category']
  end

  def project_delete
    project = Project.find(params[:project_id])
    project.destroy
  end

  def update_project
    project = Project.find(params[:project_id])
    project.update(
      name: params[:name],
      status: params[:due_date],
      progress: params[:progress],
      description: params[:description],
      due_date: params[:due_date]
    )

    category = ProjectCategory.find_by(id: params[:category])
    if category
      category.projects << project
    end

    all_users = project.users.all
    all_users.each do |user|
      if user
        project.users.delete user
      end
    end

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      if user
        project.users << user
      end
    end
  end

  def project_read
    project = Project.find(params[:project_id])
    render json: project, include: ['users','project_category']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :due_date, :status, :progress, :category, :description)
    end
end
