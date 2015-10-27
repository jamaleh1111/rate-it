class TopicsController < ApplicationController
  #redirects guess user who attempts to access actions other than index or show
  before_action :require_sign_in, except: [:index, :show]
  #check authorization, if not admin they will be redirected to the topics index view.
  before_action :authorize_user, except: [:index, :show]

  def index
    @topics = Topic.visible_to(current_user).page(params[:page]).per(5)
  end 

  def show
    @topic = Topic.find(params[:id])

    unless @topic.public || current_user
      flash[:error] = "You must be signed in to view private topics."
      redirect_to new_session_path
    end 
  end 

  def new 
    @topic = Topic.new
  end 

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      flash[:notice] = "Your topic has been saved."
      redirect_to @topic
    else
      flash[:error] = "There was a problem saving your topic, please try again."
      render :new
    end 
  end 

  def edit
    @topic = Topic.find(params[:id])
  end 

  def update 
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was a problem updating your topic, please try again."
      render :edit
    end 
  end 

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash[:error] = "There was an error deleting the topic, please try again."
      render :show
    end 
  end 

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end 

  def authorize_user
    unless current_user.admin?
      flash[:error] = "You must be an admin to do that."
      redirect_to topics_path
    end 
  end 
end
