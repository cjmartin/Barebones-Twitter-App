class MainController < ApplicationController
  before_filter :require_user
  def index
    params[:page] ||= 1
    @tweets = current_user.client.friends_timeline(:page => params[:page])
    @api_limit = current_user.client.rate_limit_status
  end
end
