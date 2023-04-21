# PowerShell SFTA

[![Latest Version](https://img.shields.io/badge/Latest-v1.0.0-green.svg)]()
[![MIT License](https://img.shields.io/github/license/mashape/apistatus.svg)]()
[![Made with Love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red.svg?colorB=11a9f7)]()

PowerShell Set TaskBar Shortcut Windows 10/11

## Features

* Pin Shortcut/Application.
* Unpin Shortcut/Application.

## Usage

##### Type Get-Help command for information

```powershell
Get-Help .\TBPin.ps1 -full
```

## Basic Usage

##### Pin Notepad:

```powershell
Add-TaskbarPin "$env:Windir\Notepad.exe"

```

##### Unpin Notepad:

```powershell
Remove-TaskbarPin "$env:Windir\Notepad.exe"

```

## Additional Instructions

##### Pin Notepad to Taskbar from Windows Command Processor (cmd.exe):

```powershell
powershell -ExecutionPolicy Bypass -command "& { . .\TBPin.ps1; Add-TaskbarPin '%windir%\Notepad.exe' }"

```

##### Pin Google Chrome to Taskbar from Windows Command Processor (cmd.exe):

```powershell
powershell -ExecutionPolicy Bypass -command "& { . .\TBPin.ps1; Add-TaskbarPin (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)' }"

```

##### Pin Notepad to Taskbar Windows Command Processor (cmd.exe) (Load Script From GitHub Raw URL):

```powershell
powershell -ExecutionPolicy Bypass -command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/DanysysTeam/PS-TBPin/master/TBPin.ps1'));Add-TaskbarPin '%windir%\Notepad.exe' }"

```

## Release History

See [CHANGELOG.md](CHANGELOG.md)

<!-- ## Acknowledgments & Credits -->

## License

Usage is provided under the [MIT](https://choosealicense.com/licenses/mit/) License.

Copyright © 2023, [Danysys.](https://www.danysys.com)