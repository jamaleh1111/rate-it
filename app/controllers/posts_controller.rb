class PostsController < ApplicationController
  #This before_action filter makes it so that unsigned in guests are redirected to a new session form. 
  #they are able to view posts, but will not be able to do the other CRUD actions.
  before_action :require_sign_in, except: :show
  #the index of posts are nexted under each topic
  # def index
  #   @posts = Post.all
  # end

  def show
    @post = Post.find(params[:id])
  end
#instantiates a new post
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end
#updates and saves to database.  POST action
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was a problem saving the post.  Please try again."
      render :new
    end
  end 

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else 
      flash[:error] = "There was an error updating the post.  Please try again."
      render :edit
    end 
  end 

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash[:error] = "There was an error deleting the post. Please try again."
      redirect_to :show
    end 
  end 

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end 
end
