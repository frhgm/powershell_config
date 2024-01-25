# oh-my-posh init pwsh | Invoke-Expression
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Import-Module PSWebConfig
# Import-Module posh-git

# Add-PoshGitToProfile -AllHosts
# $GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss")'
# $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta
# $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $false
# tab-completions to function for `choco`.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
$dev = "~\Documents\Desarrollos\Originales"
$nvconfig = "C:\Users\jdiaz\AppData\Local\nvim"
$config = "C:\Users\jdiaz\Documents\Powershell\"
$obs = "C:\Users\jdiaz\Documents\Markdown\Obsidian"
$choco = "C:\ProgramData\chocolatey\"
$wez = "C:\Users\jdiaz\AppData\Roaming\wezterm\"
$lg = "lazygit"
$LIBGL_ALWAYS_SOFTWARE = 0
$ENV:STARSHIP_CONFIG = "$HOME\AppData\Local\Starship\starship.toml"

function log {
   git log --graph --simplify-by-decoration --pretty=format:'%d' --all --decorate
}
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function launch_lazygit {
  lazygit
}
function launch_pnpx {
  pnpm dlx
}

function fz {
  fzf --preview 'bat --style numbers,changes --color=always {}'
}

# Git checkout nombre_rama
function gc {
  param([String]$branch)
  git checkout $branch
}

# TODO Crear funcion que filtre el resultado de una lista segun un parametro
function filtrar_ls {
  param([String]$filtro)
  # ls | rg -i termino
}

function devs {
Set-Location -Path ((Get-ChildItem -Directory -Path $dev | ForEach-Object { $_.FullName }) | fzf)
}

function tldr_function {
  tldr --list | fzf --preview "tldr {} --color=always" --preview-window=right,70% | ForEach-Object { tldr $_ }
}

function launch_rust_function {
  Invoke-CmdScript 'C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat' # Para inicializar Rust
}

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}



# Formato de sentencia: Set-Alias alias nombre_funcion
Set-Alias vim nvim
Set-Alias lg launch_lazygit
Set-Alias d devenv
# Set-Alias pnpm launch_pnpx
New-Alias g git
New-Alias dv devs
New-Alias tld tldr_function
New-Alias launch_rust launch_rust_function

Set-PSReadLineOption -PredictionSource History
Set-Environment SHELL="C:\Program Files\PowerShell\7\pwsh.exe"
# $GitPromptSettings.DefaultPromptWriteStatusFirst = $true
#$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n$([DateTime]::now.ToString("HH:mm"))'
# $GitPromptSettings.DefaultPromptBeforeSuffix.ForegroundColor = 0x808080
# $GitPromptSettings.DefaultPromptSuffix = ' $((Get-History -Count 1).id + 1)$(">" * ($nestedPromptLevel + 1)) '
# function prompt {"PS: $(get-date)>"}
# 

# EQUIVALENTE DE WATCH
# Get-Content nombre archivo.log -Wait


if(Test-Path 'C:\Users\jdiaz\.inshellisense\key-bindings-pwsh.ps1' -PathType Leaf){. C:\Users\jdiaz\.inshellisense\key-bindings-pwsh.ps1}

function hist { 
  $find = $args; 
  Write-Host "Buscando en historial {`$_ -like `"*$find*`"}"; 
  Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Get-Unique | fzf
}


# Con esto puedo medir el performance hit de cada linea
# Measure-Script -Top 3 $profile
