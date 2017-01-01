class profile::erlang_profile {

  if "${::operatingsystem}" == 'windows'{

    notify { 'Enter If Condidtion' : }

    $is_install   = ''
    $get_programs = 'Get-WmiObject Win32_Product | Where {$_.Name -match Microsoft Visual C }'
    $erlang_path  = 'C:\Program Files\er18.2\erts-8.2\bin'

#    exec {'Get Installed Program':
#      command  => "${is_install} = ${get_programs}",
#      provider => powershell,
#    }

    notify { 'Starting Erlang Installation': }

    exec { 'Installing Erlang':
      command  => '$(Start-Process C:\Users\ashwinder\Downloads\otp_win64_19.2.exe -ArgumentList /S -Verb RunAs -Wait)',
      unless   => '$(If((Test-Path "C:\Program Files\erl8.2\bin\erl.exe") -eq $true) {exit 0 } Else { exit 1 })',
      provider => powershell,
    }

    notify { 'Adding Path to the System Env' : }

    exec { 'Add Erlang to System Path':
      command  => "$([Environment]::SetEnvironmentVariable('ERLANG_HOME', 'C:\Program Files\erl8.2\bin', 'Machine'))",
      provider => powershell
    }
  }

}
