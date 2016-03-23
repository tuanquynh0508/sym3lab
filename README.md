Symfony 3 Lab
====
By Nguyen Nhu Tuan

A Symfony project created on February 24, 2016, 1:08 pm.

Set Virtual Host
---
```
<VirtualHost *:80>
    ServerName sym3lab.local
    ServerAlias sym3lab.local
    DocumentRoot /home/nntuan/Gits/sym3lab/web
    SetEnv sfEnv dev
    <Directory /home/nntuan/Gits/sym3lab/web>
        #Options Indexes FollowSymLinks
        AllowOverride all
        Require all granted
        <IfModule mod_rewrite.c>
            RewriteEngine On
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteRule ^(.*)$ app_dev.php [QSA,L]
            RewriteCond %{HTTP:Authorization} ^(.*)
            RewriteRule .* - [e=HTTP_AUTHORIZATION:%1]
        </IfModule>
    </Directory>
    #For Ubuntu apache config
    ErrorLog ${APACHE_LOG_DIR}/error-sym3lab.log
    CustomLog ${APACHE_LOG_DIR}/access-sym3lab.log combined

    #For Xampp windows config
    #ErrorLog "logs/error-sym3lab.log"
    #CustomLog "logs/access-sym3lab.log" combined
</VirtualHost>
```

Command Line
```
php bin/console
php bin/console cache:clear --env=dev

php bin/console assets:install --symlink web
php bin/console assetic:dump --env=dev

php bin/console doctrine:migrations:diff --env=dev
php bin/console doctrine:migrations:migrate 20160321225157 --env=dev

php bin/console generate:bundle --namespace=TuanQuynh/UserBundle --dir=src --format=annotation --no-interaction

php bin/console doctrine:generate:entities AppBundle/Entity/User
php bin/console doctrine:schema:update --force
```
