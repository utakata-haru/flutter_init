# PowerShell版 Flutter Project Init Script
# ---------------------------------
# このスクリプトは、Flutterプロジェクトのルートディレクトリで実行してください。
# bash版(init_project.sh)と同等の機能を提供します。

param(
  [Parameter(Mandatory = $false)]
  [string]$Org = "com.example",

  [Parameter(Mandatory = $false)]
  [string]$Platforms = "android,ios,web,macos",

  [Parameter(Mandatory = $false)]
  [string]$ProjectName,

  [Parameter(Mandatory = $false)]
  [string]$Description = "Flutter Clean Architecture app",

  [Parameter(Mandatory = $false)]
  [switch]$Overwrite,

  # `--empty` を無効化し、コメントありテンプレートを生成
  [Parameter(Mandatory = $false)]
  [switch]$KeepComments,

  # 確認プロンプトのスキップ
  [Parameter(Mandatory = $false)]
  [Alias('y')]
  [switch]$Yes,

  # ヘルプ表示
  [Parameter(Mandatory = $false)]
  [Alias('h')]
  [switch]$Help
)

function Show-Usage {
  Write-Host "Usage: .\AI\scripts\powershell\init_project.ps1 [options]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -Org <domain>             パッケージ org ドメイン（例: com.example)"
  Write-Host "  -Platforms <list>         生成するプラットフォーム（例: android,ios,web,macos,windows,linux)"
  Write-Host "  -ProjectName <name>       プロジェクト名（省略時はフォルダ名)"
  Write-Host "  -Description <text>       プロジェクト説明"
  Write-Host "  -Overwrite                既存ファイルを上書き（flutter create の --overwrite)"
  Write-Host "  -KeepComments             `--empty` を無効化、コメントありテンプレートを生成"
  Write-Host "  -Yes, -y                  確認なしで実行（非対話)"
  Write-Host "  -Help, -h                 このヘルプを表示"
  Write-Host ""
  Write-Host "Note:" 
  Write-Host "  このスクリプトはプロジェクト作成のみを行います。"
  Write-Host "  依存関係の追加は AI/scripts/powershell/add_dependencies.ps1 を、"
  Write-Host "  共通例外ファイルの生成は AI/scripts/powershell/init_core_exceptions.ps1 を使用してください。"
}

if ($Help) {
  Show-Usage
  exit 0
}

try {
  $RootDir = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
  Set-Location $RootDir

  Write-Host "[init] Working directory: $RootDir"

  $flutter = Get-Command flutter -ErrorAction SilentlyContinue
  if (-not $flutter) {
    Write-Host "Error: flutter が見つかりません。Flutter SDK をインストールし、PATH を設定してください。" -ForegroundColor Red
    exit 1
  }

  $versionLine = (flutter --version | Select-Object -First 1)
  Write-Host "[init] $versionLine"

  if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    $ProjectName = Split-Path -Leaf $RootDir
  }

  $createFlags = @("--platforms=$Platforms", "--org=$Org", "-t", "app")
  if ($ProjectName) { $createFlags += @("--project-name", $ProjectName) }
  if ($Overwrite) { $createFlags += "--overwrite" }
  # bash版のデフォルトに合わせ、KeepCommentsがない場合は --empty を付与
  if (-not $KeepComments) { $createFlags += "--empty" }
  if ($Description) { $createFlags += @("--description", $Description) }

  if (-not $Yes) {
    Write-Host "`n設定確認:"
    Write-Host ("  org:          {0}" -f $Org)
    Write-Host ("  platforms:    {0}" -f $Platforms)
    Write-Host ("  project-name: {0}" -f $ProjectName)
    Write-Host ("  description:  {0}" -f $Description)
    Write-Host ("  overwrite:    {0}" -f $Overwrite)
    Write-Host ("  empty:        {0}" -f (-not $KeepComments))
    $resp = Read-Host "続行しますか？ [y/N]"
    if ($resp -notmatch '^[yY]$') {
      Write-Host "中止しました"
      exit 1
    }
  }

  Write-Host ("`n[init] Running: flutter create {0} ." -f ($createFlags -join ' '))
  flutter create $createFlags .

  Write-Host "`n[done] Initialization complete."
  Write-Host "- Add dependencies: AI/scripts/powershell/add_dependencies.ps1 -Yes"
  Write-Host "- Init core exceptions: AI/scripts/powershell/init_core_exceptions.ps1 -Yes"
  Write-Host "- Run feature generator: AI/scripts/powershell/generate_feature.ps1 -Yes"
  Write-Host "- Build codegen: flutter pub run build_runner build --delete-conflicting-outputs"
} catch {
  Write-Host $_.Exception.Message -ForegroundColor Red
  exit 1
}