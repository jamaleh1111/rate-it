class FavoritesController < ApplicationController
  before_action :require_sign_in

  def create
    post = Post.find(params[:post_id]) #find the post to be favorited
    favorite = current_user.favorites.build(post: post) #create a favorite for the current user and pass in the post to establish the association
    if favorite.save
      flash[:notice] = "Post favorited."
    else 
      flash[:error] = "Favoriting failed."
    end 
    redirect_to [post.topic, post] #post show view
  end 

  def destroy
    post = Post.find(params[:post_id]) #find the post
    favorite = current_user.favorites.find(params[:id]) #find the favorite that belongs to the correct user
    if favorite.destroy #delete!
      flash[:notice] = "Post unfavorited."
    else 
      flash[:error] = "Unfavoriting failed."
    end 
      redirect_to [post.topic, post] #redirect to post#show
  end 
end
