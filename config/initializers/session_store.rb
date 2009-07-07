# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rubyminds2_session',
  :secret      => '4e5f3e4de82bdc9be6dc11f7cf667dd9173cbd2bc1d7a0e5c7661ac4bc64b85ac49bf32f9ff8cec27db3e53a7414ae480288b5ce0083d9ffda498e1e98107c78'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
