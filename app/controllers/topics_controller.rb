class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end 

  def show
    @topic = Topic.find(params[:id])
  end 

  def new 
    @topic = Topic.new
  end 

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
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
end