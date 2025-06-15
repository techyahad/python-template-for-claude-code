# Claude Code 協働戦略ガイド

このドキュメントは、Claude Codeとの効果的な協働方法と、CLAUDE.mdの進化戦略について詳しく説明します。

## CLAUDE.md保守戦略

### CLAUDE.mdの情報密度の最適化

**高優先度情報（最初の100行以内）**
- 頻繁に使用するコマンド
- 重要なコーディング規約
- プロジェクト固有の制約

**中優先度情報（100-300行）**
- プロジェクト構造の詳細
- 開発環境のセットアップ
- テスト戦略

**低優先度情報（300行以降）**
- 歴史的経緯
- 稀に使用する設定
- 詳細なトラブルシューティング

### 自動更新トリガー

CLAUDE.mdは静的なドキュメントではなく、常にup-to-dateに更新される必要があります。
以下の状況でCLAUDE.mdの更新を検討してください：

1. **新しい依存関係の追加時**
   ```bash
   # 追加後にCLAUDE.mdに使用方法を記載
   uv add new-package
   ```

2. **繰り返し質問されるパターンの発見**
   - 同じ質問が3回以上発生 → CLAUDE.mdに記載
   - よくあるエラーとその解決策を蓄積

3. **プロジェクト構造の変更**
   - 新しいディレクトリの追加
   - アーキテクチャの変更
   - 設定ファイルの変更

### モジュール化戦略（大規模プロジェクト用）

```
CLAUDE.md                 # メインファイル（コア情報）
├── @docs/development.md  # 開発固有の詳細
├── @docs/deployment.md   # デプロイメント手順
├── @docs/architecture.md # アーキテクチャ決定記録
└── @docs/team-rules.md   # チーム固有のルール
```

## 効果的なフィードバックループ

### Claude Codeからの学習パターン

1. **繰り返し修正される内容の識別**
   - 型ヒントの追加パターン
   - 特定のコーディングスタイルの修正
   - テストパターンの一貫性

2. **プロジェクト固有の知識の蓄積**
   ### 例1: データベース操作のパターン
   ```python
   # 推奨: 必ずトランザクションを使用
   async with db.transaction():
       await user_repo.create(user_data)
       await audit_log.record(action)
   ```

   ### 例2: API設計ルール
   - 必ず `BaseResponse` を継承したレスポンスモデルを使用
   - エラーハンドリングは `@handle_api_errors` デコレータで統一
   - バリデーションエラーは具体的なフィールド名を含める

3. **成功指標とメトリクス**
   - Claude Codeとのやり取りでの再質問回数（目標: 30%減少）
   - 新メンバーのオンボーディング時間（目標: 50%短縮）
   - コードレビューでの指摘事項数（目標: 40%減少）

## 継続的改善プロセス

### 月次レビュー
- CLAUDE.mdの利用状況確認
- 新しく蓄積された知識の整理
- 不要になった情報の削除

### 四半期更新
- プロジェクト進化に合わせた構造見直し
- 新しいベストプラクティスの導入
- チームフィードバックの反映

## アンカーコメントの活用

コード内にClaude Code専用のアンカーコメントを活用：

```python
# AIDEV-NOTE: このクラスは外部APIとの統合専用
# AIDEV-TODO: パフォーマンス最適化が必要（レスポンス時間>500ms）
# AIDEV-QUESTION: この実装でメモリリークの可能性は？
```

### 段階的な実装アプローチ

新機能を実装する際は、以下の順序で進める：

1. **インターフェース設計**
   ```python
   # まず Protocol や ABC でインターフェースを定義
   from abc import ABC, abstractmethod

   class DataProcessor(ABC):
       @abstractmethod
       def process(self, data: Any) -> Any:
           """データを処理する"""
   ```

2. **テストファースト**
   ```python
   # 実装前にテストを書く
   def test_processor_handles_empty_data():
       processor = MyProcessor()
       assert processor.process([]) == []
   ```

3. **段階的な実装**
   - 最小限の実装から始める
   - リファクタリングで改善
   - パフォーマンス最適化は最後

## エラーメッセージの改善原則

### 1. 具体的で実用的

```python
# Bad
raise ValueError("Invalid input")

# Good
raise ValueError(
    f"Expected positive integer for 'count', got {count}. "
    f"Please provide a value greater than 0."
)
```

### 2. コンテキストを提供

```python
try:
    result = process_data(data)
except ProcessingError as e:
    raise ProcessingError(
        f"Failed to process data from {source_file}: {e}"
    ) from e
```

### 3. 解決策を提示

```python
if not config_file.exists():
    raise FileNotFoundError(
        f"Configuration file not found at {config_file}. "
        f"Create one by running: python -m {__package__}.init_config"
    )
```

## コード生成の品質基準

1. **冪等性**: 同じ操作を複数回実行しても結果が同じ
2. **防御的プログラミング**: 入力を信頼せず、常に検証
3. **リソース管理**: コンテキストマネージャーを使用

## 明確な指示のベストプラクティス

- 実装したい機能の具体的な要件を提供
- 期待される入出力の例を含める
- エッジケースを明示的に説明
- 段階的な要求（設計 → インターフェース → テスト → 実装 → 最適化）

この戦略により、CLAUDE.mdは単なる静的ドキュメントから、プロジェクトと共に進化する「生きた知識ベース」へと発展していきます。
