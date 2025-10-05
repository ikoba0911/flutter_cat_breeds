# flutter_cat_breeds

猫の種類などが確認できるアプリです。
猫の種類は10件のみ確認できます。

| 項目 | ムービー |
|:--:|:--:|
| アプリの基本動作 | <video src="https://github.com/user-attachments/assets/8c5bca46-7df8-414e-a422-387c0f06db05" width="320px"> |

## セットアップ手順

下記のコマンドで初回のセットアップを行うことができます。
```
make init
```

以降は以下のコマンドを叩くことでpackageの依存解決を行い、生成ファイルの作成などもまとめて行えます
```
make setup
```

他にもrefreshやgenfileといったMakefileに必要なコマンドをまとめています

## 簡単なアーキテクチャの説明

基本的なMVVMをベースにしています.
各レイヤの概略は以下になります。

- レイヤ構成（概略）
  - `view/`: 画面（UI）。`HomeScreen` から一覧表示、`DetailScreen` で詳細表示。
  - `view/..._view_model.dart`: 画面用の状態（Riverpod）。API 取得や再読込などのロジックを保持。
  - `model/`: Repository・API リクエスト設定・API レスポンス DTO を配置。
  - `domain/`: アプリ内で扱う不変エンティティ（`Breed`）。
  - `util/`: HTTP クライアントやセッション、リクエスト設定の共通仕組み。
  - `router/`: ルーティング名と `onGenerateRoute` による画面遷移の集約。
  - `app.dart`: `MaterialApp` 定義とルータ初期化。

- データフロー
  - UI（`HomeScreen`）→ Riverpod `HomeViewModel` → `BreedsRepository` → `HttpClient` → `catfact.ninja/breeds`
  - API レスポンス（DTO）→ `decode` → `domain/Breed` に変換 → View にバインド

## こだわりポイント

- 型安全な HTTP レイヤ
  - `HttpRequestSetting<T>` でエンドポイント・メソッド・パラメータ・ヘッダ・デコードを一元管理し、`T` で戻り値型を保証。
  - `HttpSessionSetting` を分離しており、差し替え・モックが容易（テスト容易性）。
  - 例外を `FormatException`/`TypeError`/HTTP ステータス別にラップし、原因切り分けをしやすく設計(ただし今回のアプリだとそこまで厳密なハンドリングは不要だったので行なっていません。)

- Riverpod + コード生成
  - `riverpod_annotation` によるプロバイダ生成で依存解決を明確化、再読込は `ref.invalidate(...)` で簡潔に。
  - `AsyncValue` で `loading`/`error`/`data` を分岐し UI をシンプルに記述。

- 不変データモデル
  - `freezed` + `json_serializable` により不変・コピー可能なモデルと JSON 変換を自動生成。
  - API DTO と `domain` を分離し、表示ロジックとパース処理の関心を切り離し。

- ルーティングの集約
  - `AppRouter` に画面遷移を集約し、`AppRouteName` でルート名を一元管理。画面間引数は型（`Breed`）で受け渡し。

- シンプルな UI/UX
  - 一覧・詳細・戻るの最小構成で動作検証を容易にし、リスト再読み込みボタンでエラーハンドリング体験を確認可能。
