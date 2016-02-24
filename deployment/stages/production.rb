set :stage, :prod
set :symfony_env, "prod"

# edit IP / Port and SSH user of your production server
server '10.190.5.65', user: 'root', port: 22, roles: %w{app db web}

set :branch, 'master' # your production branch
#set :deploy_to, '/data/www/sym3cms' # path on production server

set :controllers_to_clear, ["app_*.php"]
set :composer_install_flags, '--prefer-dist --no-interaction --optimize-autoloader'
SSHKit.config.command_map[:composer] = "php #{shared_path.join("composer.phar")}"
