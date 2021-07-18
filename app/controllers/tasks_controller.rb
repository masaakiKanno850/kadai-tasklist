class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :edit,:new, :show]
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :show ]
  def index
     # @pagy, @users = pagy(User.order(id: :desc), items: 25)
     # @tasks = Tasks.all
      if logged_in?
       @pagy, @tasks = pagy(Tasks.all, items: 5)
       @tasks = current_user.tasks.build  # form_with 用
       @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
      end
  end
  
  def show

  end

  def new
    @tasks = Tasks.new
  end

  def create
    @tasks = current_user.tasks.build(tasks_params)
    

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
    params.require(:tasks).permit(:content, :status)
  end
  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end
end