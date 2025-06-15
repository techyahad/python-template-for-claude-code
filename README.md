# Python Template for Claude Code

[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![uv](https://img.shields.io/badge/uv-latest-green.svg)](https://github.com/astral-sh/uv)
[![Ruff](https://img.shields.io/badge/code%20style-ruff-000000.svg)](https://github.com/astral-sh/ruff)
[![Checked with mypy](https://www.mypy-lang.org/static/mypy_badge.svg)](https://mypy-lang.org/)
[![CI](https://github.com/discus0434/python-template-for-claude-code/actions/workflows/ci.yml/badge.svg)](https://github.com/discus0434/python-template-for-claude-code/actions/workflows/ci.yml)

[Claude Code](https://www.anthropic.com/claude-code)を中心に開発するための、厳格な型チェック、自動フォーマット、CIを備えたモダンなPythonプロジェクトテンプレートです。

## 🚀 クイックスタート

### このテンプレートを使用する

1. GitHubで「Use this template」ボタンをクリックして新しいリポジトリを作成
2. 新しいリポジトリをクローン
3. セットアップスクリプトを実行

```bash
# 新しいリポジトリをクローン
git clone https://github.com/yourusername/project-name.git
cd project-name

# セットアップ
make setup
```

セットアップスクリプトは以下を実行します：
- すべての `project_name` を実際のプロジェクト名に更新（途中でプロジェクト名を入力するように求められます）
- uvを使用してPython環境を初期化
- Claude Codeをインストール
- GitHub CLI（`gh`）をインストール（途中でログインを求められます）
- すべての依存関係をインストール
- pre-commitフックを設定
- 初期テストを実行

### 手動セットアップ（代替方法）

手動セットアップを希望する場合：

```bash
# プロジェクト名を更新
python scripts/update_project_name.py your_project_name

# uvをインストール（まだインストールしていない場合）
curl -LsSf https://astral.sh/uv/install.sh | sh

# Pythonバージョンを設定
uv python pin 3.12

# 依存関係をインストール
uv sync --all-extras

# pre-commitフックをインストール
uv run pre-commit install
uv run pre-commit install --hook-type commit-msg

# テストを実行
uv run pytest
```

## 🎯 機能

### 開発ツール
- **[uv](https://github.com/astral-sh/uv)** - 高速なPythonパッケージマネージャー
- **[Ruff](https://github.com/astral-sh/ruff)** - 超高速Pythonリンター・フォーマッター
- **[mypy](https://mypy-lang.org/)** - strictモード有効な静的型チェッカー
- **[pytest](https://pytest.org/)** - カバレッジ付きテストフレームワーク
- **[hypothesis](https://hypothesis.readthedocs.io/)** - プロパティベーステストフレームワーク
- **[bandit](https://github.com/PyCQA/bandit)** - セキュリティスキャン
- **[pip-audit](https://github.com/pypa/pip-audit)** - 依存関係の脆弱性チェック
- **[pre-commit](https://pre-commit.com/)** - コード品質用Gitフック
- **[GitHub CLI](https://cli.github.com/)** - PR, Issue発行用のコマンドラインツール
- **[Sphinx](https://www.sphinx-doc.org/)** - ドキュメント自動生成

### コード品質
- ✅ mypyによる厳格な型チェック（TypedDict・Literal対応）
- ✅ Ruffによる包括的なリントルール
- ✅ 自動コードフォーマット
- ✅ Hypothesisによるプロパティベーステスト
- ✅ 統合パフォーマンスプロファイリング
- ✅ banditによるセキュリティスキャン
- ✅ pip-auditによる依存関係の脆弱性チェック
- ✅ 包括的なセキュリティポリシー

### CI/CD
- ✅ 継続的インテグレーション用GitHub Actions
- ✅ 自動パフォーマンスベンチマーク
- ✅ PR時の性能比較とアラート
- ✅ Dependabotによる自動依存関係更新
- ✅ GitHub CLIによるPR, Issue作成機能

### ドキュメントと例
- ✅ 最適なClaude Code統合のためのCLAUDE.md
- ✅ Sphinx対応ドキュメント生成
- ✅ 包括的なセキュリティポリシー
- ✅ `docs/`ディレクトリ内のカテゴリ別ドキュメント

## 📁 プロジェクト構造

```
project-root/
├── .github/                     # GitHub Actionsの設定ファイル
│   ├── workflows/               # CI/CD + ベンチマークワークフロー
│   │   ├── ci.yml              # メインCI（テスト・リント・型チェック）
│   │   └── benchmark.yml       # パフォーマンスベンチマーク
│   ├── dependabot.yml           # Dependabotの設定
│   ├── ISSUE_TEMPLATE/          # Issueテンプレート
│   └── PULL_REQUEST_TEMPLATE.md # Pull Requestテンプレート
├── src/
│   └── project_name/            # メインパッケージ（uv syncでインストール可能）
│       ├── __init__.py
│       ├── py.typed             # PEP 561準拠の型情報マーカー
│       ├── types.py             # プロジェクト共通型定義
│       ├── core/                # コアロジック
│       │   └── example.py       # 型ヒント強化済みサンプル
│       └── utils/               # ユーティリティ
│           ├── helpers.py       # JSON・リスト・辞書操作
│           └── profiling.py     # パフォーマンス測定ツール
├── tests/                       # テストコード
│   ├── unit/                    # 単体テスト
│   │   ├── test_example.py     # 既存テスト
│   │   └── test_helpers.py     # 全ヘルパー関数テスト
│   ├── property/                # プロパティベーステスト
│   │   └── test_helpers_property.py # Hypothesis使用
│   ├── integration/             # 統合テスト
│   └── conftest.py              # pytest設定
├── docs/                        # ドキュメント
├── scripts/                     # セットアップスクリプト
├── pyproject.toml               # 依存関係・ツール設定
├── .pre-commit-config.yaml      # pre-commit設定
├── README.md                    # プロジェクト説明
└── CLAUDE.md                    # Claude Code用ガイド
```

## 🛠️ 開発

### 📋 テストの実行

```bash
# すべてのテストを実行（単体・プロパティ・統合）
make test

# カバレッジ付きで実行
make test-cov

# テスト種別で実行
uv run pytest tests/unit/ -v           # 単体テスト
uv run pytest tests/property/ -v       # プロパティベーステスト
uv run pytest tests/integration/ -v    # 統合テスト

# 特定のテストを実行
uv run pytest tests/unit/test_helpers.py -v
```

### コード品質

```bash
# コードをフォーマット
make format

# コードをリント
make lint

# 型チェック
make typecheck

# すべてのチェックを順番に実行
make check

# pre-commitで完全チェック
make check-all
```

### ⚡ パフォーマンスとプロファイリング

```bash
# パフォーマンスベンチマーク実行
make benchmark

# カスタムプロファイリング
uv run python -c "
from project_name.utils.profiling import profile_context
with profile_context() as prof:
    # 重い処理
    pass
"
```

### 🛠️ その他のコマンド

```bash
# 利用可能なコマンドを表示
make help

# キャッシュファイルの削除
make clean
```

### 📦 依存関係の管理

```bash
# ランタイム依存関係を追加
uv add requests

# 開発依存関係を追加
uv add --dev pytest-mock

# ドキュメント関連依存関係を追加
uv sync --extra docs

# すべての依存関係を同期
uv sync --all-extras

# 依存関係を更新
uv lock --upgrade
```

## 🤝 Claude Code との高度連携

このテンプレートはClaude Code用に最適化されています。`CLAUDE.md`ファイルが以下を提供します：
- プロジェクトのコンテキストと構造
- 開発ガイドライン
- `uv run`プレフィックス付きの一般的なコマンド
- 型安全性の要件
- テストパターン
- GitHub CLIの適切な使用

Claude Code使用時：
1. Claudeが自動的に`CLAUDE.md`を読み込みます
2. すべてのPythonコマンドで`uv run`を使用します
3. コードのフォーマットと型チェックが行われます
4. 新機能にはテストが作成されます
5. 必要に応じてPRを作成します

### Claude Codeの活用方法

1. **自動読み込み**: `CLAUDE.md`でプロジェクトコンテキストを自動把握
2. **型安全性**: 強化された型ヒントでバグを事前防止
3. **品質保証**: 自動リント・フォーマット・テスト実行
4. **パフォーマンス最適化**: プロファイリングツールでボトルネック特定

## 📚 ドキュメントとリソース

### メインドキュメント
- [CLAUDE.md](CLAUDE.md) - Claude Code用包括的ガイド

### 連携ガイド
- [claude-collaboration-guide.md](docs/claude-collaboration-guide.md) - 人間とClaude Codeの高度連携
- [ml-project-guide.md](docs/ml-project-guide.md) - 機械学習プロジェクト用設定
- [backend-project-guide.md](docs/backend-project-guide.md) - FastAPIバックエンド用設定

## 📋 新規プロジェクト用チェックリスト

このテンプレート使用後：

### 基本設定
- [ ] `pyproject.toml`の作者情報を更新
- [ ] LICENSEを選択・更新
- [ ] README.mdをプロジェクト説明で更新
- [ ] CLAUDE.mdにプロジェクト固有の内容を追加

### GitHubリポジトリ設定
- [ ] `main`ブランチ保護を有効化: `gh repo view --web`
- [ ] PRレビューを必須に設定
- [ ] ステータスチェック（CI）を必須に設定
- [ ] Dependabotを有効化
- [ ] Issues と Projects を有効化（必要に応じて）
- [ ] CLAUDE.mdをプロジェクト固有の内容に更新
- [ ] プロジェクト固有のベストプラクティスを追加
- [ ] チーム固有のルールがあれば`docs/`に追加

## 🔧 カスタマイズ

### 型チェックの厳格さ調整

mypyのstrictモードが最初から厳しすぎる場合：

```toml
# pyproject.toml - 基本設定から開始
[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_configs = true

# 段階的により厳格な設定を有効化
[[tool.mypy.overrides]]
module = ["project_name.core.*"]
strict = true  # まずコアモジュールにstrictモードを適用
```

### リントルールの変更

```toml
# pyproject.toml
[tool.ruff.lint]
# 必要に応じてルールコードを追加・削除
select = ["E", "F", "I"]  # 基本から開始
ignore = ["E501"]  # 行の長さはフォーマッターが処理
```

### テストカバレッジ要件の変更

```toml
# pyproject.toml
[tool.pytest.ini_options]
addopts = [
    "--cov-fail-under=60",  # 初期要件を低めに設定
]
```

## 📚 リソース

- [uv ドキュメント](https://docs.astral.sh/uv/)
- [Ruff ドキュメント](https://docs.astral.sh/ruff/)
- [mypy ドキュメント](https://mypy.readthedocs.io/)
- [pytest ドキュメント](https://docs.pytest.org/en/stable/)
- [Claude Code ベストプラクティス](https://www.anthropic.com/engineering/claude-code-best-practices)

## 📄 ライセンス

このテンプレートはMITライセンスの下でリリースされています。詳細は[LICENSE](LICENSE)をご覧ください。

あなたのプロジェクトは任意のライセンスを使用できます - LICENSEファイルを更新するだけです。
