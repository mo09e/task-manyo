## [株式会社万葉様新入社員教育課題](https://diver.diveintocode.jp/curriculums/1277)

### テーブルについて

**User**

|データ型|カラム名|
|:---|:---|
|string|name|
|string|email|
|string|password_digest|
|boolean|admin|

**Task**

|データ型|カラム名|
|:---|:---|
|string|task_name|
|text|content|
|string|status|
|datetime|deadline|
|integer|priority|
|begint|user_id|

**Label**

|データ型|カラム名|
|:---|:---|
|begint|user_id|
|begint|task_id|


### Herokuへのデプロイ方法
全てターミナル上で行う
1. デプロイをするアプリのディレクトリに移動する。
1. `$ heroku login`
1. `$ rails assets:precompile RAILS_ENV=production`
アセットプリコンパイルを行う
1. `$ git add -A`
1. `$ git commit -m "コミットメッセージ"`
1. `$ heroku create`　heroku上にアプリを作成（初回のみ）
1. 必要であればheroku上にheroku buildpackを追加する
  - `$ heroku buildpacks:set heroku/ruby`
  - `$ heroku buildpacks:add --index 1 heroku/nodejs`
1. herokuにデプロイする
  - **マスターの場合** `$ git push heroku master`
  - **branchの場合** `$ git push heroku <ブランチ名>:master`
1. `$ heroku run rails db:migrate`
