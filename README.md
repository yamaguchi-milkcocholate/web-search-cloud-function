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

- 権限を付与

```shell
gcloud projects add-iam-policy-binding `PROJECT_ID` \
      --member=serviceAccount:`PROJECT_NUMBER`-compute@developer.gserviceaccount.com \
      --role=roles/run.builder

gcloud projects add-iam-policy-binding my-playground-458212 \
      --member=serviceAccount:1062902222689-compute@developer.gserviceaccount.com \
      --role=roles/run.builder
```

- デプロイ

```shell
gcloud run deploy python-http-function \
      --source . \
      --function hello_get \
      --base-image python310 \
      --region asia-northeast1 \
      --allow-unauthenticated
```
