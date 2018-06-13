# Generate or regenerate Yum repository metadata GPG signatures
class pulp::repomd_signatures {
  # gpg requires $HOME to be set properly, but puppet 'exec' only supports hard-
  # coding $HOME via the 'environment' parameter (it cannot read it from
  # /etc/passwd).  To work around this, use `sudo -H` to read /etc/passwd and
  # set $HOME properly.
  $shell = "/usr/bin/sudo -u apache -H /usr/bin/bash -c '"
  $set = '
    set -e'
  $loop = '
    cd /var/lib/pulp/published/yum/master/yum_distributor/ 2>/dev/null || exit 0
    for d1 in * ; do (
      cd $d1
      for d2 in * ; do (
        cd $d2/repomd
  '
  $test = '[ -e repomd.xml.asc ] || '
  $gen_sig = 'gpg --yes --detach-sign --armor repomd.xml'
  $stop = 'exit 1'
  $end = "
      ) ; done
    ) ; done
  '"

  if $::pulp::yum_regenerate_repomd_signatures {
    exec { 'yum_generate_repomd_signatures':
      command => "${shell}${loop}${gen_sig}${end}",
    }
  } else {
    exec { 'yum_generate_repomd_signatures':
      unless  => "${shell}${set}${loop}${test}${stop}${end}",
      command => "${shell}${loop}${test}${gen_sig}${end}",
    }
  }
}
