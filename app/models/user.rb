class User < ActiveRecord::Base
  acts_as_authentic
  validates_presence_of :twitter_id, :twitter_token, :twitter_secret
  attr_accessible :twitter_id, :twitter_token, :twitter_secret
  
  def oauth
    @oauth ||= Twitter::OAuth.new(TWITTER_CONFIG['key'], TWITTER_CONFIG['secret'])
  end
  
  def client
    @client ||= begin
      oauth.authorize_from_access(twitter_token, twitter_secret)
      Twitter::Base.new(oauth)
    end
  end
end
