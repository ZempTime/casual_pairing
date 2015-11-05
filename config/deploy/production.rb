set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '45.55.245.0', user: 'deploy', roles: %w{web app}
