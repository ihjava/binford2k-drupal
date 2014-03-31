class drupal::package::remote (
  $installroot = $drupal::installroot,
  $docroot     = $drupal::docroot,
  $version     = $drupal::drupalversion,
) {

  exec { 'install drupal':
    command => "/bin/tar --no-same-owner -xf /tmp/drupal-${version}.tar.gz -C ${installroot} && rm /tmp/drupal-${version}.tar.gz",
    onlyif  => "/usr/bin/wget http://ftp.drupal.org/files/projects/drupal-${version}.tar.gz -O /tmp/drupal-${version}.tar.gz",
    creates => "${installroot}/drupal-${version}",
  }

  file { $docroot:
    ensure => symlink,
    target => "drupal-${version}",
    force  => true,
  }

}
