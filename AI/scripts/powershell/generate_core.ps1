# PowerShell版 Core ディレクトリ生成スクリプト
# ---------------------------------
# Coreディレクトリ構造を生成するスクリプト（bash版 generate_core.sh 相当）

param(
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
  Write-Host "Usage: .\AI\scripts\powershell\generate_core.ps1 [-Yes] [-Help]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -Yes, -y                  Skip confirmation prompt (non-interactive)."
  Write-Host "  -Help, -h                 Show this help."
  Write-Host ""
  Write-Host "Note: 共通例外ファイルの生成は AI/scripts/powershell/init_core_exceptions.ps1 を使用してください。"
}

if ($Help) {
  Show-Usage
  exit 0
}

try {
  $RootDir = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
  Set-Location $RootDir

  Write-Host "✨ Coreディレクトリ生成を開始します ✨" -ForegroundColor Green

  if (-not $Yes) {
    Write-Host "以下のディレクトリを生成します。よろしいですか？ (y/N)"
    Write-Host "  - lib/core/routing"
    Write-Host "  - lib/core/routing/path"
    Write-Host "  - lib/core/theme"
    Write-Host "  - lib/core/api"
    Write-Host "  - lib/core/exceptions"
    Write-Host "  - lib/core/database"
    Write-Host "  - lib/core/database/table"
    $resp = Read-Host
    if ($resp -notmatch '^[yY]$') {
      Write-Host "処理を中断しました。"
      exit 0
    }
  }

  $dirs = @(
    "lib/core/routing",
    "lib/core/routing/path",
    "lib/core/theme",
    "lib/core/api",
    "lib/core/exceptions",
    "lib/core/database",
    "lib/core/database/table"
  )

  Write-Host "🚀 ディレクトリを生成中..."
  foreach ($d in $dirs) {
    New-Item -ItemType Directory -Force -Path $d | Out-Null
  }

  Write-Host "✅ 完了: Coreディレクトリが正常に作成されました！" -ForegroundColor Green
} catch {
  Write-Host $_.Exception.Message -ForegroundColor Red
  exit 1
}