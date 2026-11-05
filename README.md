# quiz-app

オンライン早押しクイズアプリ。

| ディレクトリ | 役割 | 技術 |
| --- | --- | --- |
| `mobile/` | クライアントアプリ | React Native (Expo) / TypeScript |
| `server/` | バックエンド | Go |

## 必要なもの

- Node.js と npm
- Go 1.24 以上
- スマホに [Expo Go](https://expo.dev/go)（実機で動かす場合）

## 使い方

```bash
make setup    # 依存関係をインストール
make mobile   # Expo 開発サーバーを起動し、表示された QR を Expo Go で読む
make web      # ブラウザで起動
make server   # Go サーバーをホットリロードで起動
make check    # lint + 型チェック + テスト
```

`make help` で全コマンドを表示する。
