# kokeibo

## サービス概要
子どもの教育費を貯めたいパパママへ 
「いつ」「いくら」必要かを教えてくれる
教育費積立シュミレーションアプリです

## メインのターゲットユーザー
- 子育て中のパパママ
- これから子どもを考えるプレパパママ

## ユーザーが抱える課題
- いつまでにどのぐらい必要なのか分からない
- 将来部活や学費で出費が増えるので、子どもが小学生の内に貯めておきたい。

## 解決方法
- 目標積立金額から逆算し、教育費積立の予算を立てることができる

## 実装予定の機能
ゲストユーザー向け
- 予算シュミレーション機能
  - 公立私立が選択できる
  - 月々いくら積み立てたら良いのか金額が分かる
  - まとまった資金が必要な時期の貯蓄予定額が分かる
  - グラフや図で積立予定金額の推移が見られる

会員向け
- サインアップ機能
  - 会員登録ができる
- ログイン・ログアウト機能
- 積立計画機能
  - 予算シュミレーションを保存・編集・閲覧ができる
- 入金管理機能
  - 実際に積立した金額を入力できる
  - 今まで積み立てた金額をグラフで見ることができる
  - 積立計画と誤差がある場合、計画を自動で修正してくれる
- 希望進路管理機能
  - 希望進路を選択できる
  - 希望進路をもとに必要な教育費が確認できる

後から追加したい機能
- 退会機能
- パートナー共有機能
  - パートナーの登録・削除ができる
  - パートナーと積立計画を共有できる
- 子ども管理機能
  - 子どもの登録・削除ができる
  - 子どもが複数人いる場合、それぞれの子どもの積立状況を分けて見ることができる
- 運用推奨通知機能
  - すぐには使わない資金を運用に回すよう通知してくれる
  - ユーザーによってオンオフができる
- スタンプカード機能
  - 実際に積立をしたらスタンプカードにスタンプを押せる
  - 過去のスタンプ一覧を見ることができる
- 積立予定日通知機能
  - 毎月決まった日付に積立をしたかをLINEで通知してくれる

## なぜこのサービスを作りたいのか?
子どもの出産を機に将来の教育費を貯め始めたが、学資保険は利率が悪い上に引き出せる時期が決まっていて使いづらいことから自分で積立を決意。  
教育費を算出するシュミレーション機能はいろんなサイトが提供しているが、総支出額だけではなく積立計画まで立てられるアプリが欲しいと思った。また貯めた資金をいつ使うかが分かれば運用に回しやすいので、いついくら使うかが目で見て分かるものが欲しいと思った。住宅、老後に次いで教育費は三大資金の一つ。教育費積立に特化したアプリがあったら面白いと思った。

## スケジュール
4月中　市場調査・企画
~5/9 ER図  
~5/12 画面遷移図   
~7/31 実装  
8/6 MVPリリース  
8/13 本リリース

## 画面遷移図
https://www.figma.com/file/ym6L6BtjalGczAeJyhYsSJ/%E3%82%B3%E3%82%B1%E3%83%BC%E3%83%9C?node-id=7-194&t=D1431jr47oNpVVHN-0