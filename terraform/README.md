# Terraform

## ディレクトリ構造

- 環境ごとに分ける
  - prod: 本番環境
  - dev: 作成していないが開発環境
- 共有リソース
  - resource
    - iam などの認証系はここ
- 共通機能
  - module: 環境差分はあるが機能としては共通しているもの
