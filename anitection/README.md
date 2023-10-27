# anitection
Anitectionのフロントエンド(Flutter)のプロジェクト

## Getting Started
.env.exampleを.envにリネームして、環境変数を設定してください。<br>
環境変数は以下の通りです。<br>
```
BASE_URL=APIのURL
```

## 構成
Flutterバージョン: 3.10.6<br>

## ディレクトリ構成
```
anitection
├── README.md
├── android
├── anitection.iml
├── build
├── ios
├── lib
│   ├── main.dart
│   ├── models
│   ├── providers
│   ├── screens
│   ├── clients
│   ├── utils
│   ├── components
```

## よく使うコマンド
### コード生成コマンド
RetrofitやJsonSerializableのコードを生成するコマンド。<br>
RetrofitやJsonSerializableのコードを変更した場合は、このコマンドを実行する必要があります。<br>
```
flutter pub run build_runner build --delete-conflicting-outputs
```