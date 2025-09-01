# PowerShell 版 Flutter Feature Generator Script
# ---------------------------------
# このスクリプトは、Flutterプロジェクトのルートディレクトリで実行してください。
# 対話形式または引数指定でフィーチャー名と権限レベルを受け取り、
# 既存のクリーンアーキテクチャ構造に基づいてディレクトリ構造を自動生成します。

param(
  # フィーチャー名（例: UserProfile, order_history）
  [Parameter(Mandatory = $false)]
  [Alias('n','name')]
  [string]$Name,

  # 権限（1|2|3|4 または admin|user|shared|direct）
  [Parameter(Mandatory = $false)]
  [Alias('p','permission')]
  [string]$Permission,

  # 明示的な権限レベル（admin|user|shared|direct）
  [Parameter(Mandatory = $false)]
  [Alias('l','permissionlevel')]
  [string]$PermissionLevel,

  # 確認プロンプトのスキップ
  [Parameter(Mandatory = $false)]
  [Alias('y','yes')]
  [switch]$Yes,

  # ヘルプ表示
  [Parameter(Mandatory = $false)]
  [Alias('h','help')]
  [switch]$Help
)

function Show-Usage {
  Write-Host "Usage: .\AI\generate_feature.ps1 [-Name <NAME>] [-Permission <NUM_OR_STR>] [-PermissionLevel <LEVEL>] [-Yes] [-Help]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -Name, -n                 Feature name (e.g., UserProfile or order_history)"
  Write-Host "  -Permission, -p           Permission (1|2|3|4 or admin|user|shared|direct)"
  Write-Host "  -PermissionLevel, -l      Same as -Permission but uses explicit level string"
  Write-Host "  -Yes, -y                  Skip confirmation prompt (non-interactive)"
  Write-Host "  -Help, -h                 Show this help"
}

if ($Help) {
  Show-Usage
  exit 0
}

# 開始メッセージ
Write-Host "✨ Flutterフィーチャー生成スクリプトを開始します ✨" -ForegroundColor Green

# --- フィーチャー名の入力 or 引数 ---
if (-not $Name) {
  $Name = Read-Host "Enter the feature name (e.g., UserProfile, order_history)"
}

if (-not $Name) {
  Write-Host "❌エラー: フィーチャー名が入力されていません。処理を中断します。"
  exit 1
}

# --- 権限レベルの決定 ---
if ($PermissionLevel) {
  $PermissionLevel = $PermissionLevel.ToLower()
} else {
  if ($Permission) {
    switch -Regex ($Permission.ToLower()) {
      '^1$'     { $PermissionLevel = 'admin'; break }
      '^2$'     { $PermissionLevel = 'user'; break }
      '^3$'     { $PermissionLevel = 'shared'; break }
      '^4$'     { $PermissionLevel = 'direct'; break }
      '^admin$' { $PermissionLevel = 'admin'; break }
      '^user$'  { $PermissionLevel = 'user'; break }
      '^shared$'{ $PermissionLevel = 'shared'; break }
      '^direct$'{ $PermissionLevel = 'direct'; break }
      default   { Write-Host "Unknown permission: $Permission"; Show-Usage; exit 0 }
    }
  } else {
    Write-Host "Select the permission level:"
    Write-Host "  1) admin"
    Write-Host "  2) user"
    Write-Host "  3) shared"
    Write-Host "  4) direct (features下に直接配置)"
    $choice = Read-Host "Enter number (default: 2)"
    switch ($choice) {
      '1' { $PermissionLevel = 'admin' }
      '3' { $PermissionLevel = 'shared' }
      '4' { $PermissionLevel = 'direct' }
      Default { $PermissionLevel = 'user' }
    }
  }
}

Write-Host ("-> 選択された権限レベル: {0}" -f $PermissionLevel) -ForegroundColor Yellow

# --- フィーチャー名をsnake_caseに変換（大文字→小文字、スペース/ハイフン→アンダースコア） ---
$featureSnake = $Name.ToLower().Replace(' ', '_').Replace('-', '_')

# --- ベースパスの算出 ---
if ($PermissionLevel -eq 'direct') {
  $basePath = "lib/features/$featureSnake"
} else {
  $basePath = "lib/features/$PermissionLevel/$featureSnake"
}

Write-Host ("-> 生成パス: {0}" -f $basePath) -ForegroundColor Yellow
Write-Host "-----------------------------------------------------"

# --- 確認 ---
if (-not $Yes) {
  $confirm = Read-Host "以下のディレクトリ構造を生成します。よろしいですか？ (y/n)"
  if ($confirm -ne 'y') {
    Write-Host "処理を中断しました。"
    exit 0
  }
}
Write-Host "-----------------------------------------------------"

# --- ディレクトリ生成 ---
Write-Host "🚀 ディレクトリを生成中..."

$dirs = @(
  # Core ディレクトリ（存在しない場合のみ作成）
  "lib/core/routing",
  "lib/core/theme",
  "lib/core/api",
  "lib/core/exceptions",

  # Feature ディレクトリ
  "$basePath/1_domain/1_entities",
  "$basePath/1_domain/2_repositories",
  "$basePath/1_domain/3_usecases",
  "$basePath/1_domain/exceptions",

  "$basePath/3_application/1_states",
  "$basePath/3_application/2_providers",
  "$basePath/3_application/3_notifiers",

  "$basePath/2_infrastructure/2_data_sources/1_local",
  "$basePath/2_infrastructure/2_data_sources/1_local/exceptions",
  "$basePath/2_infrastructure/2_data_sources/2_remote",
  "$basePath/2_infrastructure/2_data_sources/2_remote/exceptions",
  "$basePath/2_infrastructure/1_models",
  "$basePath/2_infrastructure/3_repositories",

  "$basePath/4_presentation/1_widgets/1_atoms",
  "$basePath/4_presentation/1_widgets/2_molecules",
  "$basePath/4_presentation/1_widgets/3_organisms",
  "$basePath/4_presentation/2_pages"
)

foreach ($d in $dirs) {
  try {
    New-Item -ItemType Directory -Path $d -Force | Out-Null
  } catch {
    Write-Host "ディレクトリ作成中にエラーが発生しました: $d" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
  }
}

Write-Host ("✅ 完了: フィーチャー「{0}」のディレクトリが正常に作成されました！" -f $featureSnake) -ForegroundColor Green