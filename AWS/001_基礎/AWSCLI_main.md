以下の記事を参考に。  
https://dev.classmethod.jp/articles/aws-cli_initial_setting/

- AWS CLIに必要なことは以下
  - `.aws/creadentials`の設定
  - `.aws/config`の設定
  - IAMユーザーのアクセスキー・シークレットアクセスキー

- 設定方法
- とりあえず１つの環境で使えればよい場合  
→ デフォルトの設定のままで使用する

  ```sh
  $ aws configure
    AWS Access Key ID [None]: {アクセスキーID}
    AWS Secret Access Key [None]: {シークレットアクセスキー}
    Default region name [None]: ap-northeast-1
    Default output format [None]: json
  ```

  - 上記でデフォルトのクレデンシャル情報が設定できる。中身は以下で確認できる。
  ```
  $ cat credentials
    [default]
    aws_access_key_id = {アクセスキーID}
    aws_secret_access_key = {シークレットアクセスキー}
  ```

- 複数環境でCLIを切り替えたい場合  
→ プロファイルを使用する。
  ```
  $ aws configure --profile {プロファイル名}
　  AWS Access Key ID [None]: {アクセスキーID}
    AWS Secret Access Key [None]: {シークレットアクセスキー}
    Default region name [None]: ap-northeast-1
    Default output format [None]: json
  ```

  - 仮に`sample-A`と`sample-B`で分けた場合は、以下のような内容となる。
  ```
  $ cat credentials
    [sample-A]
    aws_access_key_id = {アクセスキーID}
    aws_secret_access_key = {シークレットアクセスキー}

    [sample-B]
    aws_access_key_id = {アクセスキーID}
    aws_secret_access_key = {シークレットアクセスキー}
  ```