class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
#instantiates a new post
  def new
    @post = Post.new
  end
#updates and saves to database.  POST action
  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
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
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to @post
    else 
      flash[:error] = "There was an error updating the post.  Pleas try again."
      render :edit
    end 
  end 

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash[:error] = "There was an error deleting the post. Please try again."
      redirect_to :show
    end 
  end 

  # private
  # def post_params

  # end 
end
