iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
chocolatey feature enable -n allowGlobalConfirmation
