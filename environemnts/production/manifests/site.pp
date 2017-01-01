File { backup => false }

node default {
  notify { 'Hello': }
}

node 'PuppetAgent1' {
  notify { 'Entering the installation': }

  include role::winserver

  notify { 'VC' : }
  include role::erlang_role
}
