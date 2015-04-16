$sites = [ 'one.mysite.com', 'two.mysite.com', 'three.mysite.com' ]

package { 'php':
  ensure => '5.2.4',
} ->

package { [ 'mysql', 'httpd', 'php-mysql',  ]:
  ensure => present,
} ->

service { ['mysql', 'httpd']:
  ensure => running,
  enable => true,
} ->

drupal::site { $sites:
  ensure => present,
}



