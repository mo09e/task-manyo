class TasksController < ApplicationController
  before_action :set_task, only: [:show]

  def index
    @task = Task.all
  end

  def show
  end

  private
  def task_params
    params.require(:myword).permit(:task_name, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
