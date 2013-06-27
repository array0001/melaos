class PostsController < ApplicationController

 before_filter :admin_user, :only => [:destroy]
  
  def create
    @post = Post.new(params[:post])
      if @post.save
     
      flash[:success] ="Publicacion exitosa"
      redirect_to root_path
      
      else
        @post = []
        render 'pages/home'
      end
  end
  
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_path
  end
  
  
  private 
 
    def admin_user
      redirect_to(root_path) unless usuario_actual.admin?
    end
  
end
