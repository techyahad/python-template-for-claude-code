# CLAUDE.md

このファイルは、[Claude Code](https://www.anthropic.com/claude-code) がこのリポジトリのコードを扱う際のガイダンスを提供します。

## プロジェクト概要

**プロジェクトを開始する前に、必ずこの項目をプロジェクトに特化したものに更新してください。**

このプロジェクトは、[Claude Code](https://www.anthropic.com/claude-code) での開発に最適化されたPythonプロジェクトテンプレートです。
厳格な型チェック、自動化されたコード品質管理、CIに加えて、GitHub CLIを使用したGitHub操作をサポートします。
また、[Claude Code](https://www.anthropic.com/claude-code) との協働をサポートするためのドキュメントも提供します。

### 開発方針

- **パッケージ構造**: コアロジックは `src/project_name` に配置し、パッケージとして管理
- **依存関係管理**: `uv` を使用し、`uv sync` で開発環境を構築
- **コード品質**: `ruff` によるリント・フォーマット、`mypy` による型チェック
- **自動化**: `pre-commit` によるコード品質の自動チェック
- **CI/CD**: GitHub Actionsによる継続的インテグレーション

## 技術スタック

- **言語**: Python 3.12+
- **主要ツール**: uv (パッケージ管理), Ruff (リント・フォーマット), mypy (型チェック), pytest (テスト)
- **パッケージ管理**: uv
- **リンター/フォーマッター**: ruff
- **型チェッカー**: mypy (strict mode)
- **テストフレームワーク**: pytest
- **自動化**: pre-commit, GitHub Actions

## プロジェクト構造(デフォルト。必要に応じて更新してください)

```
project-root/
├── .github/                     # GitHub Actionsの設定ファイル
│   ├── workflows/               # GitHub Actionsのワークフロー
│   ├── dependabot.yml           # Dependabotの設定
│   ├── ISSUE_TEMPLATE.md        # Issueテンプレート
│   └── PULL_REQUEST_TEMPLATE.md # Pull Requestテンプレート
├── src/
│   └── project_name/            # メインパッケージ（uv syncでインストール可能）
│       ├── __init__.py
│       ├── py.typed             # PEP 561準拠の型情報マーカー
│       ├── core/                # コアロジック
│       ├── utils/               # ユーティリティ
│       └── ...
├── tests/                       # テストコード
│   ├── unit/                    # 単体テスト
│   ├── integration/             # 統合テスト
│   └── conftest.py              # pytest設定
├── docs/                        # ドキュメント
├── scripts/                     # ユーティリティスクリプト
├── pyproject.toml               # uv/ruff/mypyの設定ファイル
├── .gitignore                   # バージョン管理除外ファイル
├── .pre-commit-config.yaml      # pre-commitの設定ファイル
├── README.md                    # プロジェクトの説明
└── CLAUDE.md                    # このファイル
```

## コーディング規約

### Python コーディングスタイル

- **型ヒント**: Python 3.12+ の型ヒントを必ず使用（mypy strict mode準拠）
- **Docstring**: NumPy形式のDocstringを使用
- **命名規則**:
  - クラス: PascalCase
  - 関数/変数: snake_case
  - 定数: UPPER_SNAKE_CASE
  - プライベート: 先頭に `_`
- **インポート順序**: 標準ライブラリ → サードパーティ → ローカル（ruffが自動整理）
- **インポート形式**: `from project_name.module import function`

### 型ヒントのベストプラクティス

```python
from typing import Any, TypeVar, Generic, Protocol
from collections.abc import Sequence, Mapping, Iterator

T = TypeVar("T")

class DataProcessor(Protocol):
    """データプロセッサのプロトコル定義"""
    def process(self, data: Sequence[T]) -> list[T]: ...

def process_items(
    items: Sequence[str],
    processor: DataProcessor,
    *,  # キーワード専用引数を強制
    max_items: int | None = None,
) -> list[str]:
    """
    アイテムを処理する。

    Parameters
    ----------
    items : Sequence[str]
        処理対象のアイテムリスト
    processor : DataProcessor
        データプロセッサ
    max_items : int | None, optional
        処理する最大アイテム数、デフォルトは制限なし

    Returns
    -------
    list[str]
        処理済みアイテムのリスト
    """
    if max_items is not None:
        items = items[:max_items]
    return processor.process(items)
```

## よく使うコマンド

### 基本的な開発コマンド（Makefile使用）

```bash
# 開発環境のセットアップ
make setup                  # 依存関係インストール + pre-commitフック設定など

# テスト実行
make test                   # テスト実行
make test-cov               # カバレッジ付きテスト実行

# コード品質チェック
make format                 # コードフォーマット
make lint                   # リントチェック（自動修正付き）
make typecheck              # 型チェック
make security               # セキュリティチェック（bandit）
make audit                  # 依存関係の脆弱性チェック（pip-audit）

# 統合チェック
make check                  # format, lint, typecheck, testを順番に実行
make check-all              # pre-commitで全ファイルをチェック

# GitHub操作
make pr                     # PRテンプレートを使用してPR作成
make issue-bug              # バグレポートのイシュー作成
make issue-feature          # 機能要望のイシュー作成
make issue-claude           # Claude Codeからの要望や改善要求のイシュー作成
make issue                  # イシュー作成（テンプレート選択）

# その他
make clean                  # キャッシュファイルの削除
make help                   # 利用可能なコマンド一覧

# 依存関係の追加
uv add package_name
uv add --dev dev_package_name
```

### 直接実行する場合（uv run使用）

```bash
# Makefileが使えない環境での代替コマンド
uv run pytest
uv run ruff format .
uv run ruff check . --fix
uv run mypy src/ --strict
uv run pre-commit run --all-files
```

## GitHub操作のベストプラクティス

Claude Codeは `gh` コマンドを使用してGitHub操作を行うことができます。

### プルリクエスト作成

```bash
# 基本的なPR作成
gh pr create --title "Feature: Add new functionality" --body "Description of changes"

# テンプレートを使用したPR作成
gh pr create --template .github/PULL_REQUEST_TEMPLATE.md

# ドラフトPRの作成
gh pr create --draft --title "WIP: Working on feature"
```

### イシュー管理

```bash
# イシューの作成
gh issue create --title "Bug: Fix authentication" --body "Description"

# イシューの一覧表示
gh issue list

# イシューの詳細表示
gh issue view 123
```

## 実装戦略

このプロジェクトで作業する際は、以下の点に特に注意してください：

1. **開発環境**
   - すべてのPythonコマンドに `uv run` を前置
   - 新しい依存関係は `uv add` で追加（直接 pyproject.toml を編集しない）

2. **コード品質**
   - 型ヒントは省略しない（mypy strict mode準拠）
   - 新しいコードを書いた後は必ず `uv run ruff format .` を実行
   - テストを書く際は、正常系・異常系・エッジケースをカバー

3. **パッケージ構造**
   - コアロジックは必ず `src/project_name` パッケージ内に配置
   - インポートは `from project_name.module import ...` の形式を使用

4. **エラーハンドリング**
   - 適切な例外クラスを定義して使用
   - エラーメッセージは具体的で actionable に
   - コンテキストを提供し、解決策を提示する

5. **テスト**
   - 新機能には必ず対応するテストを追加
   - テストメソッド名は日本語で意図を明確に（例: `test_正常系_ユーザー登録が成功する`）

6. **コミット前の確認**
   - `uv run pre-commit run --all-files` でチェックをパス
   - テストがすべて通ることを確認

7. **GitHub操作**
   - リポジトリ作成時は `gh repo create` を使用
   - PR作成時は `.github/PULL_REQUEST_TEMPLATE.md` を活用
   - ブランチ保護設定でコード品質を保持
   - `gh` コマンドを使った効率的なワークフロー


## トラブルシューティング

### よくある問題と解決策

#### 1. pre-commitが失敗する

```bash
# キャッシュをクリア
uv run pre-commit clean
uv run pre-commit gc

# 再インストール
uv run pre-commit uninstall
uv run pre-commit install
```

#### 2. mypyが大量のエラーを出す

```bash
# 特定のファイルだけチェック
uv run mypy src/project_name/specific_module.py

# 型スタブのインストール
uv add --dev types-requests types-pyyaml
```

#### 3. GitHub ActionsでCIが失敗

```bash
# ローカルで同じ環境を再現
uv sync
uv run pytest
uv run mypy src/ --strict
uv run ruff check .
```

## 段階的な導入のベストプラクティス

### 初期設定を緩めに

- 最初はすべての厳密なチェックを有効にしない
- プロジェクトが成熟するにつれて徐々に厳しくする

### 継続的な改善

- 定期的にCLAUDE.mdを見直して更新
- 新しいベストプラクティスを追加

## 詳細ガイドの参照

以下の専用ガイドを必要に応じてインポートしてください。

### Claude Code協働戦略

@docs/claude-collaboration-guide.md をインポートしてください。

主にClaude Codeと協働する人間向けのドキュメントですが、共通して参考になる部分もあります。
段階的カスタマイズ、動的ルール追加、フィードバックループの詳細を含みます。

### プロジェクトタイプ別専用ガイド

プロジェクトの性質に応じて、以下の専用ガイドを動的にインポートできます：

#### 機械学習プロジェクト

機械学習プロジェクトの場合、@docs/ml-project-guide.md をインポートしてください。

このガイドには以下が含まれます：
- PyTorch, numpy, pandas の設定
- Weights & Biases (wandb) の統合手順
- Hydra による設定管理
- GPU環境の最適化
- 実験管理のベストプラクティス
- データバージョニング戦略

#### バックエンドAPI プロジェクト

FastAPI を使用したバックエンドプロジェクトの場合、@docs/backend-project-guide.md をインポートしてください。

このガイドには以下が含まれます：
- FastAPI + Pydantic の設定
- SQLAlchemy による非同期データベース操作
- JWT認証とセキュリティ設定
- API設計のベストプラクティス
- Docker開発環境
- プロダクション考慮事項

### カスタムガイドの追加

プロジェクト固有の要件に応じて、追加のガイドを`docs/` ディレクトリに作成できます。
例: フロントエンドプロジェクトのガイド(`docs/frontend-project-guide.md`), チーム固有のルール(`docs/team-specific-guide.md`)など
