# リポジトリ直下から mobile / server の両方を操作するための入口。
# Go のツールはバージョンを固定して `go run` で実行する（グローバルインストール不要。初回だけビルドに時間がかかる）。
AIR      := go run github.com/air-verse/air@v1.67.4
GOLANGCI := go run github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.15.0

# server/ に Go ファイルができるまでは、server 側の lint / test をスキップする
# （パッケージが 1 つも無いと go vet / go test がエラー終了するため）。
GO_FILES := $(shell find server -name '*.go' -print -quit)
SKIP_GO   = @echo "server: Go ファイルがまだ無いのでスキップ"

.DEFAULT_GOAL := help
.PHONY: help setup mobile web server test lint fmt check

help: ## コマンド一覧を表示
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F ':.*## ' '{printf "  make %-8s %s\n", $$1, $$2}'

setup: ## 依存関係をインストールし、git フックを有効にする
	cd mobile && npm install
	cd server && go mod download
	git config core.hooksPath .githooks

mobile: ## Expo 開発サーバーを起動（Expo Go で QR を読む）
	cd mobile && npx expo start

web: ## Expo をブラウザで起動
	cd mobile && npx expo start --web

server: ## Go サーバーをホットリロードで起動（server/cmd/api/main.go が必要）
	cd server && $(AIR)

test: ## 全テスト
ifneq ($(GO_FILES),)
	cd server && go test -race ./...
else
	$(SKIP_GO)
endif
	cd mobile && npm test

lint: ## lint と型チェック
ifneq ($(GO_FILES),)
	cd server && go vet ./... && $(GOLANGCI) run ./...
else
	$(SKIP_GO)
endif
	cd mobile && npm run lint && npm run typecheck

fmt: ## Go コードを整形
	cd server && $(GOLANGCI) fmt ./...

check: lint test ## lint + テスト（git push の前に自動で走る）
