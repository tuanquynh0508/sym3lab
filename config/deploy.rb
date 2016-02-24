lock '3.4.0'

set :application, 'sym3cms'
set :repo_url, 'https://github.com/tuanquynh0508/sym3lab.git'
set :linked_files, %w{app/config/parameters.yml}
set :linked_dirs, %w{var/logs vendor web/vendor node_modules web/assets}

set :format, :pretty
set :log_level, :debug
set :keep_releases, 5

after 'deploy:starting', 'composer:install_executable'
#after 'deploy:updated', 'npm:install'   # remove it if you don't use npm
#after 'deploy:updated', 'bower:install' # remove it if you don't use bower
after 'deploy:updated', 'symfony:assets:install'
after 'deploy:updated', 'symfony:assetic:dump'
