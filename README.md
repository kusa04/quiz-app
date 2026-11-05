# quiz-app

オンライン早押しクイズアプリ。

| ディレクトリ | 役割 | 技術 |
| --- | --- | --- |
| `mobile/` | クライアントアプリ | React Native (Expo) / TypeScript |
| `server/` | バックエンド | Go |

## MVP

ルーム ID を教え合った 2 人が、1 対 1 で対戦する。

- 問題文は 1 文字ずつ表示され、わかった時点でボタンを押す。
- 解答は、答えのひらがなを 1 文字ずつ 3 択から選ぶ。
- 正解 +1 点、誤答 -1 点（0 点未満にはならない）。5 点先取で勝ち。

詳しい要件は [docs/mvp.md](docs/mvp.md) にある。

## 必要なもの

- Node.js と npm
- Go 1.24 以上
- スマホに [Expo Go](https://expo.dev/go)（実機で動かす場合）

## 使い方

```bash
make setup    # 依存関係をインストールし、git フックを有効にする
make mobile   # Expo 開発サーバーを起動し、表示された QR を Expo Go で読む
make web      # ブラウザで起動
make server   # Go サーバーをホットリロードで起動
make check    # lint + 型チェック + テスト。git push の前に自動で走る
```

`make help` で全コマンドを表示する。
