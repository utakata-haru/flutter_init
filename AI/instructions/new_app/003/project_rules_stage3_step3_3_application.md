# 💻 第三段階：実装フェーズ — ステップ3-3: Application層の実装

## 🏗️ 実装順序 — Application
- [ ] AI/architecture/lib/features/3_application/1_states/instructions.md　を確認後　states ファイル生成
- [ ] AI/architecture/lib/features/3_application/2_providers/instructions.md　を確認後　providers ファイル生成
- [ ] AI/architecture/lib/features/3_application/3_notifiers/instructions.md　を確認後　notifiers ファイル生成
- [ ] `flutter analyze` 実行・検証

> 注意: Provider と Notifier の責務分離
>
- **Notifier (`3_notifiers/`) の責務**
    - UIが直接関心を持つ状態（State）の生成、更新、管理に関する**全てのロジックをここに実装します**。
    - `UseCase`の呼び出し、API通信などの非同期処理といった副作用を管理する責任を持ちます。
    - `class`に`@riverpod`アノテーションを付けることで、`Notifier`本体の実装と、UIがアクセスするための`Provider`の定義を一体化させます。

- **Provider の責務**
    - **依存性注入Provider (`2_providers/`)**:
        - `Repository`や`UseCase`といった、アプリケーションの裏側で使われる**「部品」の依存関係を組み立てること**に特化します。
        - ドメイン層のインターフェースとインフラ層の実装クラスを結びつけ、インスタンスを生成する役割を担います。
        - このProviderに、UIの状態に関するロジックを記述することはありません。
    - **自動生成されるNotifier Provider**:
        - `Notifier`に付けた`@riverpod`アノテーションによって**自動で生成されるProvider**です。（例: `userNotifierProvider`）
        - UIと`Notifier`の実装を切り離すための、**唯一の安全なアクセスポイント（窓口）**として機能します。
        - UIは常にこのProviderを介してのみ、状態を購読（`watch`）したり`Notifier`のメソッドを呼び出したりします。