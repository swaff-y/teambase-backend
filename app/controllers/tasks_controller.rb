class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_task
    task = Task.create(
      name: params[:name],
      due_date: params[:due_date],
      status: params[:status],
      progress: params[:progress],
      category: params[:category],
      description: params[:description],
      project_id: params[:project_id]
    )

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      task.users << user
    end
    TaskCategory.find_by(id: params[:category]).tasks << task

    render json: task, include: ['users','task_category']
  end

  def delete_task
    task = Task.find(params[:task_id])
    task.destroy
  end

  def read_task
    task = Task.find(params[:task_id])
    render json: task, include: ['users','task_category']
  end

  def update_task
    task = Task.find(params[:task_id])

    task.update(
      name: params[:name],
      due_date: params[:due_date],
      status: params[:status],
      progress: params[:progress],
      category: params[:category],
      description: params[:description],
      project_id: params[:project_id]
    )

    category = TaskCategory.find_by(id: params[:category])
    if category
      category.tasks << task
    end

    all_users = task.users.all
    all_users.each do |user|
      if user
        task.users.delete user
      end
    end

    params[:assignees].each do |assignee|
      user = User.find_by(id: assignee)
      if user
        task.users << user
      end
    end
  end

  def task_priority_update
    task = Task.find(params[:task_id])

    task.update(
      priority: params[:priority]
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :start_date, :due_date, :status, :description, :project_id, :assignees)
    end
end
