# PowerShell版 Core Exceptions 初期化スクリプト
# ---------------------------------
# lib/core/exceptions の共通例外ファイル（Base/Network/Storage）を生成します。

param(
  # 既存ファイルを上書き
  [Parameter(Mandatory = $false)]
  [switch]$Overwrite,

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
  Write-Host "Usage: .\AI\scripts\powershell\init_core_exceptions.ps1 [-Overwrite] [-Yes] [-Help]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -Overwrite               既存ファイルを上書き"
  Write-Host "  -Yes, -y                 確認なしで実行（非対話)"
  Write-Host "  -Help, -h                このヘルプを表示"
  Write-Host ""
  Write-Host "Note: lib/core/exceptions/ に Base/Network/Storage の例外を生成します。"
}

if ($Help) {
  Show-Usage
  exit 0
}

try {
  $RootDir = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
  Set-Location $RootDir

  Write-Host "[core] Working directory: $RootDir"

  if (-not (Test-Path (Join-Path $RootDir 'lib'))) {
    Write-Host "Error: lib ディレクトリが見つかりません。Flutter プロジェクトのルートで実行してください。" -ForegroundColor Red
    exit 1
  }

  $TargetDir = Join-Path $RootDir 'lib/core/exceptions'
  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

  $files = @(
    (Join-Path $TargetDir 'base_exception.dart'),
    (Join-Path $TargetDir 'network_exception.dart'),
    (Join-Path $TargetDir 'storage_exception.dart')
  )

  if (-not $Overwrite) {
    foreach ($f in $files) {
      if (Test-Path $f) {
        Write-Host ("Error: {0} は既に存在します。-Overwrite を指定してください。" -f $f) -ForegroundColor Red
        exit 1
      }
    }
  }

  if (-not $Yes) {
    Write-Host ("`n生成先: {0}" -f $TargetDir)
    $resp = Read-Host "続行しますか？ [y/N]"
    if ($resp -notmatch '^[yY]$') {
      Write-Host "中止しました"
      exit 1
    }
  }

  $baseContent = @'
abstract class BaseException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const BaseException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'BaseException(message: ' + message + (code != null ? ', code: ' + code! : '') + ')';
}
'@

  $networkContent = @'
import 'base_exception.dart';

class NetworkException extends BaseException {
  const NetworkException(super.message, {super.code, super.originalError});

  factory NetworkException.connectionTimeout() =>
      const NetworkException('接続がタイムアウトしました', code: 'CONNECTION_TIMEOUT');

  factory NetworkException.noInternet() =>
      const NetworkException('インターネット接続がありません', code: 'NO_INTERNET');
}
'@

  $storageContent = @'
import 'base_exception.dart';

class StorageException extends BaseException {
  const StorageException(super.message, {super.code, super.originalError});

  factory StorageException.databaseError(String details) =>
      StorageException('データベースエラー: ' + details, code: 'DATABASE_ERROR');

  factory StorageException.fileNotFound(String path) =>
      StorageException('ファイルが見つかりません: ' + path, code: 'FILE_NOT_FOUND');
}
'@

  Set-Content -Path $files[0] -Value $baseContent -Encoding UTF8
  Set-Content -Path $files[1] -Value $networkContent -Encoding UTF8
  Set-Content -Path $files[2] -Value $storageContent -Encoding UTF8

  Write-Host "`n[core] Generated:"
  foreach ($f in $files) { Write-Host ("  - {0}" -f $f) }
} catch {
  Write-Host $_.Exception.Message -ForegroundColor Red
  exit 1
}