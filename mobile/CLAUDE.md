# mobile

React Native (Expo SDK 58) + TypeScript のクライアントアプリ。

## コマンド

```bash
npx expo start              # 開発サーバー（リポジトリ直下なら make mobile）
npx expo install <package>  # パッケージ追加は必ずこれ。npm install だと SDK と合わないバージョンが入る
npm run lint                # ESLint
npm run typecheck           # tsc --noEmit
npm test                    # Jest (jest-expo)
npx expo-doctor             # 依存関係と設定の診断
```

## ルール

- Expo は SDK のメジャーバージョンごとに API が変わる。Expo / React Native の API を使うコードを書く・説明するときは、記憶に頼らず `https://docs.expo.dev/versions/v58.0.0/` の該当ページを確認する。
- ルーティングは Expo Router。`src/app/` 配下のファイルがそのまま画面になり、`_layout.tsx` がナビゲーションを定義する。画面以外のコード（コンポーネント、hook、ユーティリティ）は `src/app/` の外（`src/components/` など）に置く。
- import は `@/` エイリアスを使う（`@/components/foo` は `src/components/foo`）。
- 動作確認は Expo Go で行う。Expo Go に含まれないネイティブモジュールを持つライブラリは development build が必要になり、この環境（Xcode / Android Studio なし）ではローカルビルドできない。追加する前にユーザーに確認する。
- `ios/` と `android/` は作らない・手で編集しない。ネイティブ側の設定は `app.json` で行う。
- React Compiler が有効（`app.json` の `experiments.reactCompiler`）。`useMemo` / `useCallback` を手で足す必要は基本的にない。

## 実機からサーバーに接続するとき

実機の Expo Go から見た `localhost` はスマホ自身を指す。Mac 上の Go サーバーには Mac の LAN 内 IP（例: `192.168.x.x:8080`）で接続する。ブラウザ（`make web`）からは `localhost` でよい。

クライアントに渡す環境変数は `EXPO_PUBLIC_` で始まる名前にして `.env` に書く（この接頭辞が無い変数はアプリから読めない）。
