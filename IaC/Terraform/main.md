# Terraformとは？
- HashiCorp社によって開発されている
- オープンソースのサービス
- IaC（Infrastructure as Code）のツールの一つ
- クラウドもコードで管理することができる
- コードで管理したクラウド環境は、自動で構築できる

# 重要なファイル
- [.tfファイル](#detail-tffile)
- [terraform.tfstateファイル](#detail-tfstate)
- [.tfvarsファイル](#details-tfvars)

# よく使うコマンド
- [terraform init](#detail-init)
- [terraform plan](#detail-plan)
- [terraform apply](#detail-apply)
- [terraform destroy](#detail-destroy)

# 覚えておくべき記述
- resource
- data
- variables 
- locals

# 早く実践したいという方向けのリンク
- [Terraformの導入手順](#install-terraform)


# それぞれのファイルの役割

<a id="#detail-tffile"></a>
## .tfファイル
- terraformがリソースの作成を行う際に、参照する情報
- 構築したいインフラのリソース情報をここに記載する

<a id="#detail-tfstate"></a>
## terraform.tfstate
- terraformは、2回目以降の実行では、初回実行時との差分のリソースを検出し、差分を適用するように動く。
- この差分の比較元となるのが、このファイル
- もっというと、初回実行した後の状態というのを、このファイルで管理している
- これがあるおかげで、一発でdestroyして作った環境をなかったことにすることもできる。
- このファイルは、コマンドを実行すると自動的に生成される。
- ## **絶対に消さないように！！**


<a id="#details-tfvars"></a>
## .tfvars
- 変数を外だしするためのファイル
- `variables.tf`は変数を宣言するが、このファイルではその宣言されたファイル内に存在する変数名に、値を設定することができる。
- このファイルの使われ方としては、環境ごとに異なる定義をしたい場合
  - `prd.tfvars`、 `stg.tfvars`、 `dev.tfvars` 等


<a id="install-terraform"></a>
# 導入手順

## **前提事項**
- aws cliのインストールと、リソース作成権限のあるIAMのアクセスキー・シークレットアクセスキーの設定が完了済みであること！  
※詳細はAWSのアウトプットを参照  
[AWS CLIの導入](/AWS/002_CLI/main.md)

- 下記のサイトを参考に導入する。  
https://zoo200.net/terraform-tfenv/
- ちなみに、terraformerというツールもあり、こちらは既に構築済みの環境から、terraform形式に落としてきてくれるらしい。  
https://zoo200.net/export-aws-with-terraformer/#toc3
- その他参考リンク  
https://www.youtube.com/watch?v=QmIqt_sdLx4

## 1. terraformを落としてくる
- `tfenv`というものが必要。githubにあるので、cloneで落としてくる
```sh
$ git clone https://github.com/tfutils/tfenv.git ~/.tfenv

# ここではホームディレクトリを指定。場所は各々で変える
$ mkdir ~/bin ; ln -snf ~/.tfenv/bin/* ~/bin
```

- インストール可能なバージョンを確認する
```sh
$ tfenv list-remote
1.4.0-rc1
1.4.0-beta2
1.4.0-beta1
1.4.0-alpha20221207
1.4.0-alpha20221109
1.3.9
1.3.8
...
```

## 2. インストール
- バージョン指定によるインストール方法と、バージョンを指定しないインストール方法がある。  
バージョンを指定しなければ、最新のものが取得される。（.terraform-versionがある場合は別）
```sh
$ tfenv install 1.3.9
```

## 3. 初期化する
- まずは作業用のディレクトリを作成する
```sh
# 任意の場所に、任意のフォルダ名をつけてください
$ mkdir terraform-work
$ cd terraform-work
```

- `terraform.tf`ファイルを作成し、Providerを指定する。
```sh
# 下記を記載して保存
provider "aws" {
  region     = "ap-northeast-1"
}
```
- terraform initを実行
```sh
$ terraform init
```

- リソースファイルを作成する。簡単に、VPCを作成してみる。  
★★途中 2023/2/27

