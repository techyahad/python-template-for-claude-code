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
- **[bandit](https://github.com/PyCQA/bandit)** - セキュリティスキャン
- **[pip-audit](https://github.com/pypa/pip-audit)** - 依存関係の脆弱性チェック
- **[pre-commit](https://pre-commit.com/)** - コード品質用Gitフック

### コード品質
- ✅ mypyによる厳格な型チェック
- ✅ Ruffによる包括的なリントルール
- ✅ 自動コードフォーマット
- ✅ banditによるセキュリティスキャン
- ✅ pip-auditによる依存関係の脆弱性チェック

### CI
- ✅ 継続的インテグレーション用GitHub Actions
- ✅ Dependabotによる自動依存関係更新

### ドキュメント
- ✅ 最適なClaude Code統合のためのCLAUDE.md
- ✅ `docs/`ディレクトリ内のカテゴリ別ドキュメント

## 📁 プロジェクト構造

```
project-root/
├── .github/                     # GitHub Actionsの設定ファイル
│   ├── workflows/               # GitHub Actionsのワークフロー
│   ├── dependabot.yml           # Dependabotの設定
│   ├── ISSUE_TEMPLATE/          # Issueテンプレート
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
└── CLAUDE.md                    # Claude Code用の説明
```

## 🛠️ 開発

### テストの実行

```bash
# すべてのテストを実行
make test

# カバレッジ付きで実行
make test-cov

# 特定のテストを実行（直接実行）
uv run pytest tests/unit/test_example.py -v
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

### その他のよく使うコマンド

```bash
# 利用可能なコマンドを表示
make help

# キャッシュファイルの削除
make clean
```

### 依存関係の追加

```bash
# ランタイム依存関係を追加
uv add requests

# 開発依存関係を追加
uv add --dev pytest-mock

# 依存関係を更新
uv lock --upgrade
```

## 🤝 Claude Code との連携

このテンプレートはClaude Code用に最適化されています。`CLAUDE.md`ファイルが以下を提供します：
- プロジェクトのコンテキストと構造
- 開発ガイドライン
- `uv run`プレフィックス付きの一般的なコマンド
- 型安全性の要件
- テストパターン

Claude Code使用時：
1. Claudeが自動的に`CLAUDE.md`を読み込みます
2. すべてのPythonコマンドで`uv run`を使用します
3. コードのフォーマットと型チェックが行われます
4. 新機能にはテストが作成されます

## 📚 ドキュメント

- [CLAUDE.md](CLAUDE.md) - Claude Code用指示
- [claude-collaboration-guide.md](docs/claude-collaboration-guide.md) - 人間とClaude Codeの連携ガイド

## 📋 新規プロジェクト用チェックリスト

このテンプレート使用後：

### 基本設定
- [ ] `pyproject.toml`の作者情報を更新
- [ ] LICENSEを選択・更新
- [ ] README.mdをプロジェクト説明で更新
- [ ] GitHub CLI（`gh`）の認証設定: `gh auth login`

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
