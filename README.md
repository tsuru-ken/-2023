## table schema
| User            | Label              | Task                 |
| :---:           | :---:              | :---:                |
| name:string     | task_id:references | title:string         |
| email:string    | user_id:references | content:text         |
| password:string |                    | limit:date        |
|                 |                    | status:integer |
|                 |                    | priority:integer     |


Herokuへのデプロイ手順 ・ruby3 系を使用している場合以下を gem に記述して bundle　install gem 'net-smtp' gem 'net-imap' gem 'net-pop'

　heroku login 　heroku create 　git add . 　git commit -m 'メッセージ'

・Heroku buildpackを追加する $ heroku buildpacks:set heroku/ruby $ heroku buildpacks:add --index 1 heroku/nodejs

・Failed to install gems via Bundler.のエラー対応 bundle lock --add-platform x86_64-linux ※再度git addから行う
・You are trying to install ruby-3.0.1 on heroku-22.のエラー対応 heroku stack 以下のコマンドで、デフォルトのheroku-22からheroku-20へstackを切り替える heroku stack:set heroku-20
・Precompiling assets failed.のエラー対応 以下のコマンドをjsonファイルに追記し、node.jsのバージョンを安定版の１６に変更 "engines": { "node": "16.x" }
・Githubとの連携 heroku上の のアプリケーションを選択し「deploy」のタブを選択 Githubを選択肢し、masterブランチを選択、connect。