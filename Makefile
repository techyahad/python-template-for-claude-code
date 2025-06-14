.PHONY: help test test-cov format lint typecheck security check check-all setup pr issue issue-bug issue-feature issue-claude clean

# デフォルトターゲット
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@echo "  setup        - セットアップ（依存関係インストール、pre-commit設定）"
	@echo "  test         - テスト実行"
	@echo "  test-cov     - カバレッジ付きテスト実行"
	@echo "  format       - コードフォーマット（ruff format）"
	@echo "  lint         - リントチェック（ruff check --fix）"
	@echo "  typecheck    - 型チェック（mypy）"
	@echo "  security     - セキュリティチェック（bandit）"
	@echo "  audit        - 依存関係の脆弱性チェック（pip-audit）"
	@echo "  check        - format, lint, typecheck, testを順番に実行"
	@echo "  check-all    - pre-commitで全ファイルをチェック"
	@echo "  pr           - PRテンプレートを使用してPR作成"
	@echo "  issue-bug    - バグレポートのイシュー作成"
	@echo "  issue-feature - 機能要望のイシュー作成"
	@echo "  issue-claude - Claude Code改善のイシュー作成"
	@echo "  clean        - キャッシュファイルの削除"

# セットアップ
setup:
	uv sync --all-extras
	uv run pre-commit install
	uv run pre-commit install --hook-type commit-msg

# テスト関連
test:
	uv run pytest

test-cov:
	uv run pytest --cov=src --cov-report=html --cov-report=term

# コード品質チェック
format:
	uv run ruff format .

lint:
	uv run ruff check . --fix

typecheck:
	uv run mypy src/ --strict

security:
	uv run bandit -r src/

audit:
	uv run pip-audit

# 統合チェック
check: format lint typecheck test

check-all:
	uv run pre-commit run --all-files

# GitHub操作
pr:
	gh pr create --template .github/PULL_REQUEST_TEMPLATE.md

issue-bug:
	gh issue create --template .github/ISSUE_TEMPLATE/bug_report.yml

issue-feature:
	gh issue create --template .github/ISSUE_TEMPLATE/feature_request.yml

issue-claude:
	gh issue create --template .github/ISSUE_TEMPLATE/claude_code_collaboration.yml

issue:
	gh issue create

# クリーンアップ
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name "htmlcov" -exec rm -rf {} +
	find . -type f -name ".coverage" -delete
