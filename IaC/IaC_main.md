# IaCとは？
- Infrastructure as Codeの略
- インフラ環境もコードで管理しましょう、なこと
- 様々なツールがある
- 一般的には、クラウド環境自体をコード管理することを目的として言われることが多い（= dockerもIaCの一つではあるが、IaCとしてくくられることは少ないイメージ（個人の感想））
- コードで管理しているので、環境を変えた時の差分もわかるようになる
- 一発で構築して、一発で破壊できるので、お金も節約できる。  
新しいサービスを試したいとなった時に、ベースラインとなる環境をすぐ構築できるのは強い。

# 比較
<!--Excel to Markdownで変換した。楽-->
| ツール名                   | 対象プラットフォーム                                                     | 記述言語               |
|------------------------|----------------------------------------------------------------|--------------------|
| AWS Cloud Formation    | AWS                                                            | YAML               |
| Azure Resource Manager | Azure                                                          | JSON               |
| Deployment Manager     | GCP                                                            | YAML,JINJA2,Python |
| Terraform              | AWS、Azure、GCP、<br/>OracleCloud、Tencent Cloud<br/>Alibaba Cloud | HCL                |
| Ansible                | プラットフォームに依存しない                                                 | YAML               |
| Chef                   | プラットフォームに依存しない                                                 | Ruby-based DSL     |

# 個人的に使ってみての感想
### Terraform
- HCLという言語ではあるが、わかりやすく、簡単な構成であればすぐに慣れることもできるため、抵抗感は少ないと思う。
- 少し難しいことをやろうと思うと、厳しいかも
- ドキュメントが充実している。



### 参考リンク
https://qiita.com/cocoa-maemae/items/8595246f444b1c08e479