class TwitterauthController < ApplicationController
  #before_filter :require_no_user
  def new
    @request_token = TwitterauthController.consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    redirect_to @request_token.authorize_url
    return
  end
  
  ##Add validation on user, find_or_create_by
  def callback
    @request_token = OAuth::RequestToken.new(TwitterauthController.consumer, session[:request_token], session[:request_token_secret])
    # Exchange the request token for an access token.
    @access_token = @request_token.get_access_token
    @response = TwitterauthController.consumer.request(:get, '/account/verify_credentials.json', @access_token, { :scheme => :query_string })
    case @response
      when Net::HTTPSuccess
        user_info = JSON.parse(@response.body)
        unless user_info['screen_name']
          flash[:notice] = "Authentication failed"
          redirect_to :action => :index
          return
        end
        @user = User.find_or_initialize_by_twitter_id(user_info['id'])
        if @user.new_record? || @user.twitter_token != @access_token.token
          @user.twitter_token = @access_token.token
          @user.twitter_secret = @access_token.secret
          @user.save!
        end
        # Store the user in the session
        UserSession.create(@user)
        # Redirect to the show page
        redirect_back_or_default root_url
      else
        RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
        # The user might have rejected this application. Or there was some other error during the request.
        flash[:notice] = "Authentication failed"
        redirect_to login_url
        return
    end
  end
  
  private
  def self.consumer
    OAuth::Consumer.new(TWITTER_CONFIG['key'], TWITTER_CONFIG['secret'], {
      :site           => TWITTER_CONFIG['site'],
      :authorize_path => "/oauth/authenticate"
    })
  end
end