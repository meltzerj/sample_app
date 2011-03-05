class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    respond_to do |format|
      if @micropost.save
        flash[:success] = "Micropost created!"
        format.html { redirect_to root_path, :notice => 'success' }
        format.js   
      else
        @feed_items = []
        render 'pages/home'
      end  
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private

      def authorized_user
        @micropost = Micropost.find(params[:id])
        redirect_to root_path unless current_user?(@micropost.user)
      end
end
