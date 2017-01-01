class profile::rabbitmq_profile {

  $service_name = 'RabbitMQ'

  if "${::operatingsystem}" == 'windows'{

    notify { 'Starting Erlang Installation': }

    exec { 'Installing Erlang':
      command   => '$(Start-Process C:\Users\ashwinder\Downloads\otp_win64_19.2.exe -ArgumentList /S -Verb RunAs -Wait)',
      unless    => '$(If((Test-Path "C:\Program Files\erl8.2\bin\erl.exe") -eq $true) { exit 0 } Else { exit 1 })',
      provider  => powershell,
      logoutput => true,
    }

    notify { 'Adding Path to the System Env' : }

    exec { 'Add Erlang to System Path':
      command   => "$([Environment]::SetEnvironmentVariable('ERLANG_HOME', 'C:\Program Files\erl8.2\bin', 'Machine'))",
      provider  => powershell,
      logoutput => true,
    }

    notify { 'Installing Rabbit MQ': }

    exec { 'Installing RabbitMQ':
      command   => '$(Start-Process C:\Users\ashwinder\Downloads\rabbitmq-server-3.6.6.exe -ArgumentList /S -Verb RunAs -Wait)',
      onlyif    => '$(if(Get-Service "${service_name}") { exit 0 } else { exit 1 })',
      provider  => powershell,
      logoutput => true,
    }
  }
}
