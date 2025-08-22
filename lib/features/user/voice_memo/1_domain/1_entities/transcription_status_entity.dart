// ドメイン層: 文字起こし状態の列挙型（MVP仕様に準拠）
// none → pending → success/failed の遷移を想定

enum TranscriptionStatus {
  none,
  pending,
  success,
  failed,
}