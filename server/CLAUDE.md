# server

Go のバックエンド。モジュール名は `github.com/kusa04/quiz-app/server`。

## コマンド

リポジトリ直下の `make server` / `make lint` / `make test` / `make fmt` を使う。個別に実行する場合:

```bash
go test -race ./...   # テスト
go vet ./...          # 静的解析
go mod tidy           # 依存関係の整理（import を足したり消したりした後）
```

## 構成

現状は `go.mod` と設定ファイルだけで、Go のコードはまだ無い。

- エントリポイントは `cmd/api/main.go`（`package main`）に置く。`.air.toml`（ホットリロード）が `./cmd/api` をビルドする前提になっているので、場所を変えるなら `.air.toml` の `cmd` も直す。
- 起動するプログラムを増やすときは `cmd/<名前>/main.go` を追加する。
- アプリのコードは `internal/` 配下にパッケージを切って置く。
- リポジトリ直下の `go.work` は、エディタ（gopls）をリポジトリ直下で開いたときに `server/` を認識させるためのもの。

## ルール

- まず標準ライブラリで足りるか考える。HTTP のルーティングは `net/http` の `ServeMux`（`"GET /path"` 形式）で書ける。
- 整形は gofmt + goimports（`make fmt`）。lint は `.golangci.yml` の設定で golangci-lint v2 を使う。
- テストは対象と同じディレクトリに `_test.go` で置き、`-race` 付きで実行する。
- `go.mod` の Go バージョンは 1.24。golangci-lint は Go 1.26 以上を要求するため、実行時に Go が自動で新しいツールチェーンをダウンロードして切り替える（`GOTOOLCHAIN=auto`）。`go.mod` のバージョンを上げる必要はない。
