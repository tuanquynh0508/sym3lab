set :stage, :staging
set :symfony_env, "dev"

set :branch, 'master' # your development branch
#set :deploy_to, '/data/www/sym3cms' # path on staging server

#set :controllers_to_clear, []
#set :composer_install_flags, '--prefer-dist --no-interaction --optimize-autoloader'

server '10.190.5.65', user: 'root', port: 22, roles: %w{app db web}# edit IP / Port and SSH user of your staging server
#SSHKit.config.command_map[:composer] = "php #{shared_path.join("composer.phar")}"
