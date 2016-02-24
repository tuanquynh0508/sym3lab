lock '3.4.0'

set :application,			'sym3cms'
set :stages,        		["dev", "rec", "prod"]
set :default_stage, 		"dev"
set :repo_url, 				'https://github.com/tuanquynh0508/sym3lab.git'
set :branch,        		ENV['BRANCH'] || 'master'
set :deploy_to,     		"/data/www/#{fetch(:application)}"
set :scm,           		:gitcopy
set :use_sudo,      		false
set :keep_releases, 		4

set :linked_dirs,   		["var", "vendor"]
set :file_permissions_users,['apache']
set :webserver_user,        "apache"
set :permission_method,     :acl
set :use_set_permissions,   true

set :composer_install_flags, '--no-dev --no-interaction --optimize-autoloader'

SSHKit.config.command_map[:composer] = "php -d memory_limit=1G #{shared_path.join("composer.phar")}"

namespace :deploy do
  after :starting, 'composer:install_executable'
end

namespace :deploy do
  #task :migrate do
  #  invoke 'symfony:console', 'doctrine:migrations:migrate', '--no-interaction'
  #end

  desc "Set the correct permissions for resource data folder"
  task :fix_permissions do
    on roles(:app) do
      execute "chmod -R 777 #{release_path}/var/Resources/data/"
      execute "chmod -R 777 #{release_path}/var/Resources/data/*"
      execute "chmod -R 777 #{release_path}/var/Resources/test.db"
    end
  end
end

after 'deploy:updated',   'symfony:assets:install'
after 'deploy:updated',   'symfony:assetic:dump'
#after 'deploy:updated',   'deploy:migrate'
after 'deploy:finished',  'deploy:fix_permissions'
