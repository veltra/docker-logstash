# Docker Logstash

**注意: このREADMEはClaudeによって自動生成されており、不正確な情報が含まれる可能性があります。**

追加プラグインとMySQLコネクタをサポートするLogstashのカスタムDockerイメージです。

## 目次

- [概要](#概要)
- [機能](#機能)
- [アーキテクチャ図](#アーキテクチャ図)
- [環境対応表](#環境対応表)
- [ディレクトリ構成](#ディレクトリ構成)
- [技術スタック](#技術スタック)
- [インストール方法](#インストール方法)
- [使用方法](#使用方法)

## 概要

このリポジトリは、事前にインストールされたプラグインとMySQLコネクタサポートを備えたLogstash 6.2.3のカスタムDockerイメージを含んでいます。このイメージは公式のElasticsearch Logstashイメージをベースにしており、データ処理とデータベース接続のための追加機能が含まれています。

## 機能

- **Logstash 6.2.3**: 公式のElasticsearch Logstashイメージをベース
- **追加プラグイン**: translate、JDBC streaming、Google BigQuery出力プラグインが事前インストール
- **MySQLコネクタ**: データベース接続用のMySQL Connector/J 5.1.46を含む
- **Docker統合**: コンテナ化環境に最適化
- **CI/CDサポート**: 自動テスト用のCircleCI設定を含む

## アーキテクチャ図

TODO: アーキテクチャ図は時間がある際に作成予定です。

## 環境対応表

TODO: 環境対応表は時間がある際に作成予定です。

## ディレクトリ構成

```
docker-logstash/
├── .circleci/                    # CircleCI設定
├── .git/                         # Gitリポジトリ
├── .gitignore                    # Git除外ルール
├── Dockerfile                    # Dockerイメージ定義
├── Makefile                      # ビルドとテスト自動化
├── README.md                     # プロジェクトドキュメント
├── README-ja.md                  # 日本語ドキュメント
├── README-prompot-for-generate.txt # README生成プロンプト
└── mysql-connector-java-5.1.46-bin.jar # MySQLコネクタライブラリ
```

## 技術スタック

- **ベースイメージ**: docker.elastic.co/logstash/logstash:6.2.3
- **コンテナランタイム**: Docker
- **CI/CD**: CircleCI
- **ビルドツール**: Make
- **データベースコネクタ**: MySQL Connector/J 5.1.46
- **Logstashプラグイン**:
  - logstash-filter-translate
  - logstash-filter-jdbc_streaming
  - logstash-output-google_bigquery

## インストール方法

### 前提条件

- Docker
- Make（ビルド自動化用）

### イメージのビルド

```bash
# リポジトリをクローン
git clone <repository-url>
cd docker-logstash

# Dockerイメージをビルド
make build
```

ビルドプロセスでは以下が実行されます：
1. ベースのLogstash 6.2.3イメージをプル
2. 必要なLogstashプラグインをインストール
3. MySQLコネクタライブラリを追加
4. `veltra/logstash`としてタグ付けされたカスタムイメージを作成

## 使用方法

### コンテナの実行

```bash
# Logstashコンテナを実行
docker run -p 9600:9600 -d --name logstash veltra/logstash
```

### インストールのテスト

```bash
# テストスイートを実行
make test
```

テストプロセスでは以下が実行されます：
1. Dockerイメージをビルド
2. Logstashコンテナを開始
3. サービスの準備完了を待機
4. HTTP API経由でプラグインのインストールを確認

### APIエンドポイント

| エンドポイント   | メソッド | 説明                                       |
| ---------------- | -------- | ------------------------------------------ |
| `/_node/plugins` | GET      | インストールされたLogstashプラグインの一覧 |
| `/_node/stats`   | GET      | Logstashノードの統計情報を取得             |
| `/_node/info`    | GET      | Logstashノードの情報を取得                 |

### 設定

このイメージには以下の事前設定されたコンポーネントが含まれています：

- **MySQLコネクタ**: `/usr/share/logstash/lib/mysql-connector.jar`で利用可能
- **作業ディレクトリ**: `/tmp`に設定
- **プラグイン**: translate、jdbc_streaming、google_bigquery出力プラグイン

### カスタム設定

カスタムLogstash設定を使用するには、設定ファイルをマウントします：

```bash
docker run -v /path/to/config:/usr/share/logstash/pipeline \
           -p 9600:9600 \
           veltra/logstash
``` 
