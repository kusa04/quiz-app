# quiz-app

オンライン早押しクイズアプリ（「みんはや」のようなもの）。モノレポ構成。

## 進め方

- アプリの実装はユーザー自身が行う。Claude は頼まれるまで実装コード（画面、hook、ハンドラ、メッセージ設計など）を書かない。
- Claude の役割は、環境まわりの整備、質問への回答、レビュー、設計の壁打ち。ライブラリ選定などの設計判断は提案に留め、決めるのはユーザー。

## 構成

| ディレクトリ | 役割 | 技術 |
| --- | --- | --- |
| `mobile/` | クライアントアプリ | React Native (Expo SDK 58) / TypeScript / Expo Router |
| `server/` | バックエンド | Go 1.24 |

各ディレクトリの `CLAUDE.md` に、そのディレクトリ固有のルールがある。

## アーキテクチャ（大枠）

- クライアントとサーバーは別プロセス。開発中は Mac 上の Go サーバーに、同じ Wi-Fi の実機（Expo Go）かブラウザから接続する。
- 早押しのようなリアルタイムのやり取りは WebSocket、それ以外（ルーム作成など）は HTTP + JSON を想定。
- 早押しの順位や正誤の判定はサーバーが行う。クライアントの時計や自己申告は信用しない。
- クライアントとサーバーでやり取りするメッセージの型は、TypeScript 側と Go 側の両方に定義が必要になる。片方を変えたら必ずもう片方も揃える。

未定のもの（決まったらここに書く）: WebSocket ライブラリ、データの永続化（DB）、認証、デプロイ先。

## コマンド

リポジトリ直下の `Makefile` が入口。`make help` で一覧が出る。

```bash
make setup    # 依存関係をインストール
make mobile   # Expo 開発サーバー（Expo Go で QR を読む）
make web      # Expo をブラウザで起動
make server   # Go サーバーをホットリロードで起動（server/cmd/api/main.go が必要）
make check    # lint + 型チェック + テスト。コミット前に実行する
make fmt      # Go コードを整形
```

`server/` に Go ファイルが 1 つも無い間は、`make lint` / `make test` の server 側はスキップされる。

## 開発環境の前提

- Xcode 本体と Android Studio は入っていない。iOS シミュレータと Android エミュレータは使えないので、動作確認は Expo Go（実機）かブラウザで行う。
- Node は mise、Go は `/usr/local/go`。Go のツール（air、golangci-lint）は Makefile からバージョン固定の `go run` で実行するので、個別のインストールは不要。
