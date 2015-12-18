server '127.0.0.1', user: 'app', roles: %w{web app db}
set :ssh_options, { port: 2222 }
set :rails_env, 'production'
