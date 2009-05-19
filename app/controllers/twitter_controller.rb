class TwitterController < ApplicationController
  before_filter :require_user
  
  def show
    @user = @current_user.client.user(params[:id])
    @api_limit = current_user.client.rate_limit_status
    #@tweets = @current_user.client.user_timeline(params[:id])
  end
end
