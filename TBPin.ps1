<#
.SYNOPSIS
    Set TaskBar Shortcut

.DESCRIPTION
    Set TaskBar Shortcut Windows 10/11

.NOTES
    Version    : 1.0.0
    Author(s)  : Danyfirex & Dany3j
    Credits    : https://geelaw.blog/entries/msedge-pins/
    License    : MIT License
    Copyright  : 2023 Danysys. <danysys.com>


.EXAMPLE
    Add-TaskbarPin "$env:Windir\Notepad.exe"
    Pin Notepad to Taskbar

.EXAMPLE
    Add-TaskbarPin (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)'
    Pin Google Chrome to Taskbar

.EXAMPLE
    Remove-TaskbarPin "$env:Windir\Notepad.exe"
    Unpin Notepad from Taskbar

.EXAMPLE
    Remove-TaskbarPin (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)'
    Unpin Google Chrome from Taskbar

.LINK
    https://github.com/DanysysTeam/PS-TBPin
    
#>

function Add-TaskbarPin {
    [CmdletBinding()]
    param (
      [Parameter( Position = 0, Mandatory = $true)]
      [ValidateScript( { Test-Path $_ })]
      [Alias("Shortcut")]
      [String]
      $FilePath
    )
    Initialize-PSTBPinTaskBarType
    [PSTBPin.TaskBar]::Pin($FilePath)
}

function Remove-TaskbarPin {
    [CmdletBinding()]
    param (
      [Parameter( Position = 0, Mandatory = $true)]
      [ValidateScript( { Test-Path $_ })]
      [Alias("Shortcut")]
      [String]
      $FilePath
    )
    Initialize-PSTBPinTaskBarType
    [PSTBPin.TaskBar]::Unpin($FilePath)
}



function Initialize-PSTBPinTaskBarType {
$code=@"
    using System;
    using System.Runtime.InteropServices;
    
    namespace PSTBPin
    {
        public static class TaskBar
        {
            [DllImport("shell32.dll", ExactSpelling = true)]
            public static extern void ILFree(IntPtr pidlList);
            [DllImport("shell32.dll", CharSet = CharSet.Unicode, ExactSpelling = true)]
            public static extern IntPtr ILCreateFromPathW(string pszPath);
    
            [ComImport()]
            [Guid("0DD79AE2-D156-45D4-9EEB-3B549769E940")]
            [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
            private interface IPinnedList3
            {
                [PreserveSig]
                void Dummy1();
                [PreserveSig]
                void Dummy2();
                [PreserveSig]
                void Dummy3();
                [PreserveSig]
                void Dummy4();
                [PreserveSig]
                void Dummy5();
                [PreserveSig]
                void Dummy6();
                [PreserveSig]
                void Dummy7();
                [PreserveSig]
                void Dummy8();
                [PreserveSig]
                void Dummy9();
                [PreserveSig]
                void Dummy10();
                [PreserveSig]
                void Dummy11();
                [PreserveSig]
                void Dummy12();
                [PreserveSig]
                void Dummy13();
                [PreserveSig]
                uint Modify(IntPtr pidlFrom, IntPtr pidlTo, uint caller);
            }
    
            [ComImport()]
            [Guid("90AA3A4E-1CBA-4233-B8BB-535773D48449")]
            [ClassInterface(ClassInterfaceType.None)]
            private class TaskbandPin
            {
            }
    
            private static readonly IPinnedList3 _taskbar = new TaskbandPin() as IPinnedList3;
    
            public static bool Pin(string filePath)
            {
                bool ret = false;
                var pil = ILCreateFromPathW(filePath);
                ret = (_taskbar.Modify(IntPtr.Zero, pil, 4) == 0);
                if (pil != IntPtr.Zero)
                {
                    ILFree(pil);
                }
                return ret;
            }
    
            public static bool Unpin(string filePath)
            {
                bool ret = false;
                var pil = ILCreateFromPathW(filePath);
                ret = (_taskbar.Modify(pil, IntPtr.Zero, 4) == 0);
                if (pil != IntPtr.Zero)
                {
                    ILFree(pil);
                }
                return ret;
            }
        }
    }
"@
 try {
    Add-Type -TypeDefinition $code
 }
 catch {
 }
}