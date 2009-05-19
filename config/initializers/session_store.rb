# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twitterapp_session',
  :secret      => '387cb99ab4da443b8a235ee1567fba327b670232ab36b2a8e06eb69934f49ccf6e6d09c9ca46ece92ba09827ec6fb99268c55676231597fe1dbe02c4199fa80d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
