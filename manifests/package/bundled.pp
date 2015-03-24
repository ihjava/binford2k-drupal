class drupal::package::bundled (
  $installroot = $drupal::installroot,
  $docroot     = $drupal::docroot,
  $version     = $drupal::drupalversion,
  $source      = undef,
) {

  if $source == undef {
    $real_source =  "puppet:///modules/drupal/drupal-${version}.tar.gz"
  } else {
    $real_source = $source
  }

  file { "/tmp/drupal-${version}.tar.gz":
    ensure => file,
    source => $real_source,
    before => Exec['install drupal'],
  }

  exec { 'install drupal':
    command => "/bin/tar --no-same-owner -xf /tmp/drupal-${version}.tar.gz",
    cwd     => $installroot,
    creates => "${installroot}/drupal-${version}",
    before  => File[$docroot],
  }

  file { $docroot:
    ensure => symlink,
    target => "drupal-${version}",
    force  => true,
  }
}
