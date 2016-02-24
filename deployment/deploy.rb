lock '3.4.0'

set :application,			'sym3cms'
set :stages,        		["staging", "production"]
set :default_stage, 		"staging"
set :repo_url, 				'https://github.com/tuanquynh0508/sym3lab.git'
set :branch,        		ENV['BRANCH'] || 'master'
set :deploy_to,     		"/data/www/#{fetch(:application)}"
set :scm,           		:git
set :use_sudo,      		false
set :format, 				:pretty
set :log_level, 			:debug
set :keep_releases, 		5

# Controllers to clear
#set :controllers_to_clear, ["app_*.php"]

#set :linked_files, 			%w{app/config/parameters.yml}
set :writable_dirs, 		%w{var/cache var/logs var/sessions vendor}
set :linked_dirs, 			%w{var/cache var/logs var/sessions vendor}
set :file_permissions_users,['apache']
set :webserver_user,        "apache"
set :permission_method,     :acl
set :use_set_permissions,   true

set :composer_install_flags, '--no-dev --no-interaction --optimize-autoloader'
SSHKit.config.command_map[:composer] = "php -d memory_limit=1G #{shared_path.join("composer.phar")}"

namespace :deploy do
  after :starting, 'composer:install_executable'

  #task :migrate do
  #  invoke 'symfony:console', 'doctrine:migrations:migrate', '--no-interaction'
  #end

  desc "Set the correct permissions for resource data folder"
  task :fix_permissions do
    on roles(:app) do
      execute "chmod -R 777 #{release_path}/var/*"
      execute "chmod -R 777 #{release_path}/vendor/*"
    end
  end
end

#after 'deploy:updated',   'symfony:assets:install'
#after 'deploy:updated',   'symfony:assetic:dump'
#after 'deploy:updated',   'deploy:migrate'
after 'deploy:finished',  'deploy:fix_permissions'
