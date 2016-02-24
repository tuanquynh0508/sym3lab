set :stage, :staging
set :symfony_env, "dev"

# edit IP / Port and SSH user of your staging server
server '10.190.5.65', user: 'root', port: 22, roles: %w{app db web}

set :branch, 'master' # your development branch
#set :deploy_to, '/data/www/sym3cms' # path on staging server

set :controllers_to_clear, []
set :composer_install_flags, '--prefer-dist --no-interaction --optimize-autoloader'
SSHKit.config.command_map[:composer] = "php -d memory_limit=1G #{shared_path.join("composer.phar")}"
