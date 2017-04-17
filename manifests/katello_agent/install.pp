# Pulp Katello_agent Install Packages
class pulp::katello_agent::install {
  package { ['katello-agent', 'gofer']: ensure => $pulp::katello_agent::version, }
  ensure_packages(['python-gofer-qpid'], {
    ensure => $pulp::katello_agent::version
  }
  )
}
