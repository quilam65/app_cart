set :stage, :production
server '104.248.121.124', user: 'deploy', roles: %w{app db web}
