# web-search-cloud-function

## 準備

- gcloud cli をインストール
  - https://cloud.google.com/sdk/docs/install?hl=ja
- プロジェクトを設定

```shell
gcloud config set project `PROJECT_ID`
```

- Python のサンプル関数をデプロイ

  - https://cloud.google.com/run/docs/quickstarts/functions/deploy-functions-gcloud?hl=ja#python

- Python パッケージをインストール

  - uv でパッケージ管理
  - `uv pip freeze > requirements.txt`で requirements.txt に書き出す

- デプロイ

```shell
cd terraform/prod
terraform apply
```
