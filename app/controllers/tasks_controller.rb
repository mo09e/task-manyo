class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(deadline: "ASC")
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: "ASC")
    else
      @tasks = current_user.tasks.order('created_at DESC')
    end

    if params[:search].present?
      if params[:task_name].present? && params[:status].present?
        @tasks = current_user.tasks.task_name_search(params[:task_name]).status_search(params[:status])
      elsif params[:task_name].present?
        @tasks = current_user.tasks.task_name_search(params[:task_name])
      elsif params[:status].present?
        @tasks = current_user.tasks.status_search(params[:status])
      else
        @tasks = current_user.tasks.order('created_at DESC')
      end
    end

    if params[:label_id].present?
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
    end

    @tasks = @tasks.page(params[:page]).per(7)
  end

  def new
    @labels = Label.all
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: t('msg.new')
      else
        render :new
      end
    end
  end

  def edit
    @labels = Label.all
  end

  def update
    @labels = Label.all
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('msg.edit')
    else
      render :edit
    end
  end

  def show
  end

  # def confirm
  #   @task = current_user.tasks.build(task_params)
  #   render :new if @task.invalid?
  # end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('msg.destroy')
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content, :deadline, :status, :sort_expired, :priority, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
