class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(deadline: "ASC")
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: "ASC")
    else
      @tasks = Task.all.order('created_at DESC')
    end

    if params[:search].present?
      if params[:task_name].present? && params[:status].present?
        @tasks = Task.task_name_search(params[:task_name]).status_search(params[:status])
      elsif params[:task_name].present?
        @tasks = Task.task_name_search(params[:task_name])
      elsif params[:status].present?
        @tasks = Task.status_search(params[:status])
      else
        @tasks = Task.all.order('created_at DESC')
      end
    end
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを投稿しました"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "'タスクを編集しました'"
    else
      render :edit
    end
  end

  def show
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content, :deadline, :status, :sort_expired, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
