class php {
package {'apache2':
ensure => present,
}
package {'libapache2-mod-php7.2':
ensure => present,
}
package {'php7.2':
ensure => present,
}
package {'php7.2-xml':
ensure => present,
}
package {'php7.2-gd':
ensure => present,
}
package {'php7.2-opcache':
ensure => present,
}
package {'php7.2-mbstring':
ensure => present,
}
package {'composer':
ensure => present,
}
service {'apache2':
ensure => running,
enable => true,
}
package {'git':
ensure => present,
}
exec { 'delete laravel':
   cwd => '/etc/apache2/sites-available',
   command => 'rm -rf laravel.conf',
   path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin','/usr/games','/usr/local/games'],
}

file { 'laravel.conf':
    path    => '/etc/apache2/sites-available/laravel.conf',
    ensure  => file,
    source  => 'puppet:///modules/php/laravel.conf',
  }
exec { 'deleting a laravel':
   cwd => '/var/www/html',
   command => 'rm -rf laravel5-example',
   path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin','/usr/games','/usr/local/games'],
}
#file { 'laravel5-example':
#    ensure => directory,
#    path => '/var/www/html/laravel5-example',
#    source => 'puppet:///modules/php/laravel5-example',
#    recurse => true,
#}
file { "/var/www/html":
   ensure => "directory",
   source => "puppet:///modules/php/laravel5-example",
   recurse => "remote",
   }
exec { 'creating a laravel':
   cwd => '/var/www/html',
   command => 'sudo chgrp -R www-data /var/www/html/laravel5-example;sudo chmod -R 775 /var/www/html/laravel5-example/storage' ,
   path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin','/usr/games','/usr/local/games'],
}
exec { 'command1':
   cwd => '/etc/apache2/sites-available',
   command => 'sudo a2dissite 000-default.conf;sudo a2ensite laravel.conf;sudo a2enmod rewrite;sudo service apache2 restart',
   path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin','/usr/games','/usr/local/games'],
}
exec { 'php artisan':
   cwd => '/var/www/html/laravel5-example',
   command => 'php artisan key:generate',
   path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin','/usr/games','/usr/local/games'],
}
}
