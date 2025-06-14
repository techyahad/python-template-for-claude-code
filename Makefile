.PHONY: help test test-cov format lint typecheck security check check-all setup pr issue clean

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
	@echo "  pr           - PR作成 (TITLE=\"タイトル\" BODY=\"本文\" [LABEL=\"ラベル\"])"
	@echo "  issue        - イシュー作成 (TITLE=\"タイトル\" BODY=\"本文\" [LABEL=\"ラベル\"])"
	@echo "  clean        - キャッシュファイルの削除"

# セットアップ
setup:
	chmod +x scripts/setup.sh && ./scripts/setup.sh

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
	@if [ -z "$(TITLE)" ]; then \
		echo "Error: TITLE is required. Usage: make pr TITLE=\"タイトル\" BODY=\"本文\" [LABEL=\"ラベル\"]"; \
		exit 1; \
	fi
	@if [ -z "$(BODY)" ]; then \
		echo "Error: BODY is required. Usage: make pr TITLE=\"タイトル\" BODY=\"本文\" [LABEL=\"ラベル\"]"; \
		exit 1; \
	fi
	@if [ -n "$(LABEL)" ]; then \
		gh pr create --title "$(TITLE)" --body "$(BODY)" --label "$(LABEL)"; \
	else \
		gh pr create --title "$(TITLE)" --body "$(BODY)"; \
	fi

issue:
	@if [ -z "$(TITLE)" ]; then \
		echo "Error: TITLE is required. Usage: make issue TITLE=\"タイトル\" BODY=\"本文\" [LABEL=\"ラベル\"]"; \
		exit 1; \
	fi
	@if [ -z "$(BODY)" ]; then \
		echo "Error: BODY is required. Usage: make issue TITLE=\"タイトル\" BODY=\"本文\" [LABEL=\"ラベル\"]"; \
		exit 1; \
	fi
	@if [ -n "$(LABEL)" ]; then \
		gh issue create --title "$(TITLE)" --body "$(BODY)" --label "$(LABEL)"; \
	else \
		gh issue create --title "$(TITLE)" --body "$(BODY)"; \
	fi

# クリーンアップ
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name "htmlcov" -exec rm -rf {} +
	find . -type f -name ".coverage" -delete
