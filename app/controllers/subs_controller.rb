class SubsController < ApplicationController
  before_action :set_sub, only: [:edit, :update, :show, :is_moderator?]
  before_action :require_moderator, only: [:edit, :update]

  helper_method :is_moderator?

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      flash[:notice] = 'Sub created successfully'
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @sub.update_attributes(sub_params)
      flash[:notice] = 'Sub updated successfully'
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
  end

  def is_moderator?
    @sub.moderator == current_user
  end

  private

  def require_moderator
    redirect_to sub_url(@sub) unless is_moderator?
  end

  def set_sub
    @sub = Sub.find_by_id(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
