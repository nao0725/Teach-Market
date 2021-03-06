# Teach Market

<img width="1680" alt="スクリーンショット 2021-09-30 14 34 56" src="https://user-images.githubusercontent.com/78492401/135393433-e67d8f2d-f81e-48dc-be1d-7fed5138028d.png">


### サイトURL:https://teachmarket.work/

## 📚　サイト概要

社会に出ると、職種や業界によって様々な仕事があり、多種多様な仕事のやり方があります。  
しかし、学生の頃のように、座って講義や授業を受ける仕組みとは違って、  
社会人になると、上司から教わったこと以外はすべて自ら勉強しなくてはなりません。  

「どのようなやり方をすれば、成果が上がるかわからない」  
「新たに挑戦する職種や業界に不安がある」  

そのような悩みを抱えている方に向けて「TeachMarket」を作成しました。

このアプリは、以下の使い道があります。

* 仕事術を学んで自身の職場で活かす  
* うまくいったことをアウトプットする  
* 他業界、他職種の仕事を学ぶ


### サイトテーマ
社会人のための仕事術共有SNS


### 制作背景

前職で成果が上がらないときにうまく行っている方のやり方を聞き、  
教えて頂いた通りにそのまま真似をしたらうまくいった経験がありました。  
その経験がきっかけで、社内だけでなく、  
社外のビジネスマンはどのように仕事の成果を挙げているのだろうと考えました。  
そんな情報共有の場がほしい。そう考えてSNSとして作成しました。


### ターゲットユーザ
* 業務未経験者   
* 新卒１年目の社会人  
* 成果が出せずに悩んでいるビジネスマン  


### 主な利用シーン
* 社外の同業の職種のビジネスマンと情報共有したいとき  
* 問題の解決方法がわからず、困っているとき  
* 他者の仕事のやり方や仕組みを知りたいとき  


### 実装機能

#### 技術的なポイント

* gem "redcarpet"を使用したマークダウン記法
* 検索機能をgemなしで追加(Article,Tagの２つのモデルから検索可) 
* SNS認証機能実装によるログイン簡略化
* GitHub Actionsによる自動デプロイ
* Certbotを使用したhttps化
　

#### 基本機能

|  |  機能 | Gem |
|:-:|:-:|:-:|
| ①| CRUD処理 |   |
| ②  | Rspec  |  capybara,rspec-rails,factory_bot_rails,faker|
| ③| 管理者機能 |  devise |
| ④| 退会機能 |   |
|⑤|画像投稿・処理|ImageMagick,refile-mini_magick,refile|


#### 誰でも使いやすくするための仕組み

|  |  機能 | Gem |
|:-:|:-:|:-:|
| ①| SNS認証ログイン | omniauth  |
| ②  |  ゲストログイン |   |
| ③  |   ユーザー認証 | devise  |


#### 記事を見やすくする仕組み

|  |  機能 | Gem |
|:-:|:-:|:-:|
| ①| タイムライン |   |
| ②  | 複数タグ付け  |   |
|③|検索||
|④|マークダウン|redcarpet, coderay|
|⑤|ソート||
|⑥|ランキング||
|⑦|Bookmark（Ajax）||
|⑧|評価（Ajax）||
|⑨|コメント||
|⑩|ページング|kaminari|
|  ⑪ |  Bootstrap | bootstrap4  |
|⑫|SCSS||

#### 共有しやすくするための仕組み

|  | 機能 | Gem |
|:-:|:-:|:-:|
|① |  SNSシェア | social-share-button  |
|  ② | フォロー（Ajax）  |   |
|  ③ |  通知 |   |


## 🔨設計書
* [ER図](https://drive.google.com/file/d/1B185DuGwsnpNo9yjG0awdqL2sQn2BM55/view?usp=sharing)  
* [テーブル定義書](https://docs.google.com/spreadsheets/d/1A5KM2_L5cCc9Z5HoCv-Sb53mCVr2KMUcpVeb3-B8L-8/edit#gid=1680649053)  
* [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1kVK594ee1MZnoaQOUkd6coFeEyLxNwgPHwDcOj0Ogz0/edit#gid=2133469642)  


## 🔥チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1qh3XRlaqKE1pOhLJYvqeXxRPOft19IBGIF97nd3Y0pI/edit#gid=1863392946


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9


## 本番環境
- AWS (EC2、RDS)
- Nginx、 Puma
- Github actionを用いた自動デプロイ


## 使用素材
- [O-DAN](https://o-dan.net/ja/)
- [unDraw](https://undraw.co/illustrations)


## リンク
- [Qiita](https://qiita.com/nao0725)
- [Twitter](https://twitter.com/Aiza_Uw)

