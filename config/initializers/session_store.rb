# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tiikitter_session',
  :secret      => '50b835bb5338e5443db818328f1ec291f19caa181eb93322ec88eecedac9b2957e981e4e8c754df0601452c3e08358cf9c78ca97f9d1480e53f722d473cef181'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
