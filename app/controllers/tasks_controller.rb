class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Tasks.all
  end
  
  def show
  end

  def new
    @tasks = Tasks.new
  end

  def create
    @tasks = Tasks.new(tasks_params)

    if @tasks.save
      flash[:success] = 'タスク が正常に投稿されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスク が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @tasks.update(tasks_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasks.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_index_url
  end
  private
  
  def set_tasks
    @tasks = Tasks.find(params[:id])
  end

  def tasks_params
    params.require(:tasks).permit(:content)
  end
  
end