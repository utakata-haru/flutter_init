# PowerShell版 Add Dependencies Script
# ---------------------------------
# 推奨依存関係を pubspec.yaml に追加するユーティリティ（bash版 add_dependencies.sh 相当）

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
  Write-Host "Usage: .\AI\scripts\powershell\add_dependencies.ps1 [-Yes] [-Help]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -Yes, -y                  確認なしで実行（非対話)"
  Write-Host "  -Help, -h                 このヘルプを表示"
  Write-Host ""
  Write-Host "Note: ランタイム依存と開発依存をまとめて追加します。"
  Write-Host "      必要に応じて pubspec.yaml を編集して調整してください。"
}

if ($Help) {
  Show-Usage
  exit 0
}

try {
  $RootDir = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
  Set-Location $RootDir
  Write-Host "[deps] Working directory: $RootDir"

  $flutter = Get-Command flutter -ErrorAction SilentlyContinue
  if (-not $flutter) {
    Write-Host "Error: flutter が見つかりません。Flutter SDK をインストールし、PATH を設定してください。" -ForegroundColor Red
    exit 1
  }

  if (-not (Test-Path (Join-Path $RootDir 'pubspec.yaml'))) {
    Write-Host "Error: pubspec.yaml が見つかりません。プロジェクトルートで実行してください。" -ForegroundColor Red
    exit 1
  }

  if (-not $Yes) {
    Write-Host ""
    Write-Host "追加予定の依存関係:"
    Write-Host "  [runtime]"
    Write-Host "    hooks_riverpod, riverpod_annotation, go_router, freezed_annotation,"
    Write-Host "    drift, sqlite3_flutter_libs, path, dio, flutter_hooks"
    Write-Host "  [dev]"
    Write-Host "    build_runner, freezed, riverpod_generator, drift_dev"
    $resp = Read-Host "続行しますか？ [y/N]"
    if ($resp -notmatch '^[yY]$') {
      Write-Host "中止しました"
      exit 1
    }
  }

  Write-Host "`n[deps] Adding runtime dependencies"
  flutter pub add `
    hooks_riverpod `
    riverpod_annotation `
    go_router `
    freezed_annotation `
    drift `
    sqlite3_flutter_libs `
    path `
    dio `
    flutter_hooks

  Write-Host "`n[deps] Adding dev dependencies"
  flutter pub add --dev `
    build_runner `
    freezed `
    riverpod_generator `
    drift_dev

  Write-Host "`n[deps] Done."
} catch {
  Write-Host $_.Exception.Message -ForegroundColor Red
  exit 1
}