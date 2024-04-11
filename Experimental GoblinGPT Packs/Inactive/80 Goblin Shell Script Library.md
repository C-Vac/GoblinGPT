# Write-Goblin\Write-Goblin.psm1

```powershell
# Prints a message in the host output stream and logs it to a file
function Build-LogMessage {
    param (
        [string]$Message,
        [string]$Level,
        [datetime]$Timestamp
    )

    # Define the maximum message length for terminal output
    $maxTerminalLength = 128

    # Format the timestamp
    $formattedTimestamp = $Timestamp.ToString("yyyy-MM-dd HH:mm:ss")

    # Initialize the log entry
    $logEntry = "$formattedTimestamp [$Level] $Message"

    # Truncate the message for terminal output if the level is not 'Debug'
    if ($Level -ne 'Debug' -and $Message.Length -gt $maxTerminalLength) {
        $truncatedMessage = $Message.Substring(0, $maxTerminalLength) + "..."
        $logEntry = "$formattedTimestamp [$Level] $truncatedMessage"
    }

    return $logEntry
}
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "Info",
        [string]$LogFile
    )

    # Get the current timestamp
    $currentTimestamp = Get-Date

    # Build the log message
    $logEntry = Build-LogMessage -Message $Message -Level $Level -Timestamp $currentTimestamp

    # Write the log entry to the console
    Write-Host $logEntry

    # If a log file is specified, append the log entry to the file
    if ($LogFile) {
        Add-Content -Path $LogFile -Value $logEntry
    }
}

# Example usage:
Write-Log -Message "This is an information message." -Level "Info" -LogFile "example.log"
Write-Log -Message "This is a debug message that will not be truncated." -Level "Debug"

# Test with an Info level message that is under 128 characters
Write-Log -Message "This is a short info message." -Level "Info"

# Test with a Debug level message that is over 128 characters
$longDebugMessage = "This is a very long debug message that should not be truncated regardless of its length. It contains detailed information useful for debugging purposes."
Write-Log -Message $longDebugMessage -Level "Debug"

# Test with an Error level message that is over 128 characters
$longErrorMessage = "This is a very long error message that should be truncated because it exceeds the maximum length allowed for non-debug messages."
Write-Log -Message $longErrorMessage -Level "Error"


Export-ModuleMember -Function Build-LogMessage, Write-Log
```

# Write-Goblin\Write-Goblin.psd1
```powershell
#
# Module manifest for module 'Write-Goblin'
#
@{
    ModuleVersion     = '0.0.3'
    GUID              = '727c1712-79a9-48ce-adcb-4cf15eecf23c'
    Author            = 'Glass Goblin'
    CompanyName       = 'GG OCDware'
    Copyright         = 'Copyright (c) 2024 Glass Goblin OCDware'

    FunctionsToExport = ('*')

    # Script module or binary module file associated with this manifest.
    RootModule        = 'Write-Goblin.psm1'

    # Description of the functionality provided by this module
    Description       = 'Custom logging module'

    VariablesToExport = '*'

    # Aliases to export from this module
    AliasesToExport   = '*'

    # List of all files packaged with this module
    FileList          = @('Write-Goblin.psm1')

}

```
# Write-Goblin\Write-Goblin.old.psm1
```powershell
function Write-Goblin {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [ValidateSet("info", "debug", "warning", "error", "wtf")]
        [Alias('L')]
        [string]$Level = "info",
        #: 

        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)]
        [string[]]$Message
    )

    # Get/create path for log file
    $logDir = [System.Environment]::GetEnvironmentVariable('GOBLIN_LOG_DIR', 'Machine')

    if (-not (Test-Path -Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }
    $logFile = Join-Path $logDir "GoblinScript.log"

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Map aliases to the Level parameter values
    switch ($Level) {
        "i" { $Level = "info" }
        "d" { $Level = "debug" }
        "w" { $Level = "warning" }
        "e" { $Level = "error" }
        "!" { $Level = "wtf" }
        default { $Level = $Level }
    }

    # The default messages for each level
    # info: "just wanted to say hi!"
    # debug: "something interesting happened."
    # warning: "A warning message"
    # error: "An error occurred"
    # wtf: "A WTF message"

    # Combine the message array into a single string
    $MessageText = if ($Message) { $Message -join ' ' } else { $null }

    # If $MessageText is null, set it to a default value based on $Level
    if (-not $MessageText) {
        $MessageText = switch ($Level) {
            "debug" { "something interesting happened at (location) in (file)" }
            "warning" { "Default warning message." }
            "error" { "Default error message." }
            "wtf" { "Default WTF message." }
            default { "Default info message." }
        }
    }

    # Print to terminal window
    switch ($Level) {
        "info" { Write-Host "INFO: $MessageText" -ForegroundColor White }
        "debug" { Write-Host "DEBUG: $MessageText full: $logFile" -ForegroundColor Green }
        "warning" { Write-Host "WARNING: $MessageText full: $logFile" -ForegroundColor Yellow }
        "error" { Write-Host "ERROR: $MessageText full: $logFile" -ForegroundColor Red }
        "wtf" { Write-Host "WTF: $MessageText full: $logFile" -ForegroundColor Magenta }
    }

    # Example usage:
    # Write-Goblin -i "This is an informational message."
    # Write-Goblin -w "This is a warning message."


    # Build log entry

    $logEntry = "$timestamp [$Level] $MessageText`r`n"

    # Check log file
    if (Test-Path $logFile) {
        $fileInfo = Get-Item $logFile
        $maxSizeKB = 1024
        $maxLines = 512
        $currentLineCount = (Get-Content $logFile).Count
        if ($fileInfo.Length -gt ($maxSizeKB * 1KB) -or $currentLineCount -ge $maxLines) {
            Clear-Content $logFile
        }
    }

    Add-Content -Path $logFile -Value $logEntry

    # If the level is 'error', show a dialog box and/or open the log file in VS Code
    if ($Level -eq 'error') {
        $vscodePath = Get-Command code -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
        if ($vscodePath) {
            & $vscodePath --goto "${logFile}:$currentLineCount:1"
        }
        else {
            [System.Windows.MessageBox]::Show("Error occurred: $Message`r`nCheck the log file at $logFile", "Goblin Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
        }
    }
}

```
# GoblinUtils\ExportProjectStructure.ps1
```powershell
param (
    [string]$REPO_ROOT
)

Write-Goblin "Starting Auto-Tree Builder in ${REPO_ROOT}."
if (-not (Test-Path -Path $REPO_ROOT -PathType Container)) {
    Write-Goblin "The path '$REPO_ROOT' is invalid or does not exist. Aborting operation."
    return
}

# -- Configuration --
$OUTPUT_ROOT = "G:\Library\Project_Trees"
$repoName = Split-Path $REPO_ROOT -Leaf
$projectOutputDir = Join-Path $OUTPUT_ROOT $repoName

$treeOptions = @{
    "all"           = @{ 
        "IncludeDirs"  = $true;
        "IncludeFiles" = $true 
    }
    "only_folders"  = @{
        "IncludeDirs"  = $true;
        "IncludeFiles" = $false
    }
    "source_csharp" = @{
        "IncludeDirs"  = $false;
        "IncludeFiles" = $true; 
        "Include"      = "*.cs";
        "Exclude"      = "**\\bin\*";
    } 
    # TODO: implement exclude pattern
    # TODO: implement symbol generation
}

# -- Tree Generation --
function Set-Tree {
    param (
        [string]$path,
        [string]$treeType
    )
    
    New-Item -ItemType Directory -Force -Path $projectOutputDir

    $treeFile = Join-Path $projectOutputDir ($treeType + ".txt")
    try {
        if ($treeOptions[$treeType].IncludeFiles -and $treeOptions[$treeType].IncludeDirs) {
            tree /f $path | Out-File $treeFile  
        }
        elseif ($treeOptions[$treeType].IncludeDirs) {
            tree $path | Out-File $treeFile
        }
        else {
            Get-ChildItem $path -Recurse -File -Filter $treeOptions[$treeType].Include |
            Select-Object -ExpandProperty FullName |
            ForEach-Object { $_.Replace($path + '\', '') } | Out-File $treeFile
        }
        Write-Goblin "Generated tree for $treeType at $treeFile"
    }
    catch {
        Write-Goblin "Failed to generate tree for ${treeType}: $_"
    }
}

# -- Generate Trees and Symbols --
foreach ($treeName in $treeOptions.Keys) {
    Set-Tree $REPO_ROOT $treeName
}

Write-Goblin "Finished Auto-Tree Builder."

```

# GoblinUtils\SimpleProjectTree.ps1
```powershell
tree /f /a > "G:/Library/Project_Trees/sample_tree.txt"

```
# GoblinUtils\SerializeVariables.ps1
```powershell
# Function to convert a dictionary to a JSON object
function ConvertTo-JsonFromDictionary {
    param([System.Collections.IDictionary]$Dictionary)
    $output = @{}
    foreach ($key in $Dictionary.Keys) {
        $output[$key] = $Dictionary[$key]
    }
    return $output | ConvertTo-Json
}

# Get process-level environment variables
$processVars = Get-ChildItem Env: | ForEach-Object { @{ $_.Name = $_.Value } }

# Get user-level environment variables
$userVars = [System.Environment]::GetEnvironmentVariables('User')

# Get machine-level environment variables
$machineVars = [System.Environment]::GetEnvironmentVariables('Machine')

# Convert to JSON and output to files
$processVars | ConvertTo-Json | Out-File -FilePath "process_environment_variables.json"
ConvertTo-JsonFromDictionary -Dictionary $userVars | Out-File -FilePath "user_environment_variables.json"
ConvertTo-JsonFromDictionary -Dictionary $machineVars | Out-File -FilePath "machine_environment_variables.json"

# Optionally, print them to the console
Write-Output "Process-level environment variables:"
$processVars | ConvertTo-Json

Write-Output "User-level environment variables:"
ConvertTo-JsonFromDictionary -Dictionary $userVars

Write-Output "Machine-level environment variables:"
ConvertTo-JsonFromDictionary -Dictionary $machineVars

```
# GoblinUtils\GoblinUtils.psm1
```powershell
. $PSScriptRoot\Write-Goblin.ps1
. $PSScriptRoot\ExportProjectStructure.ps1

```
# GoblinUtils\GoblinUtils.psd1
```powershell
@{
    ModuleVersion     = '0.0.3'
    GUID              = '727c1712-79a9-48ce-a2cb-4cf15eecf23c'
    Author            = 'Big Ounce & GG'
    CompanyName       = 'GG OCDware'
    Copyright         = 'Copyright (c) 2024 Glass Goblin OCDware'
    FunctionsToExport = ('*')
}
# sign script >> Set-AuthenticodeSignature -FilePath "C:\Path\To\YourScript.ps1" -Certificate $cert

```
# git-hooks\pre-commit
```bash
#!/bin/sh
gitRepoRootDir="$(git rev-parse --show-toplevel)"

echo "Pre-commit hook started in: $gitRepoRootDir"

# Launch PowerShell and check if Write-Goblin module is available
powershell.exe -ExecutionPolicy Bypass -Command "& {
    \$module = 'Write-Goblin'
    if (Get-Module -ListAvailable -Name \$module) {
        Import-Module \$module
        G:\Library\PS\Modules\GoblinUtils\ExportProjectStructure.ps1 -ProjectRoot '$gitRepoRootDir'
    } else {
        Write-Host 'The required module Write-Goblin is not installed.' -ForegroundColor Red
        exit 1
    }
}"

```
