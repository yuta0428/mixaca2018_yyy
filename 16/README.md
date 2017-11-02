# OTP: サーバー

* OTP(_Open Telecon Paltform_)
    * 大規模システム開発、管理の汎用的なツール
    * システムをアプリケーションの階層に定義する
    * ビヘイビア : OTP規約

* スーパーバイザ
    * プロセスの死活を監視する特別なビヘイビア
    
* https://github.com/yuta0428/mixaca2018_yyy/blob/elixir/16/sequence/lib/sequence/server.ex

* `use GenServer`
    * GenServerというサーバーのビヘイビア
    * コールバックを定義しなくて良いことになる

* `def handle_call(:next_number, _from, current_number) do`
    * OTPが呼び出す関数
    * 第1引数 : クライアントが渡した最初の引数の情報　アクション識別子
    * 第2引数 : クライアントのPID
    * 第3引数 : サーバーの状態
    
* `{:reply, current_number, current_number+1 }`
    * `:reply`クライアントへ返答し、2つ目の要素を返すようOTPに指示している
    * 3番目の要素が次の状態

* `start_link`関数
    * GenServerに新しいプロセスを開始して、リンクするように依頼する
    * 失敗すれば、通知来る
    * 第3引数にオプションを渡せる `[debug: [:trace]]`, `name: プロセス名`

* `GenServer.call`
    * 第1引数 : PID
    * 第2引数 : 実行したいアクション識別子 `handle_call`の第1引数
    * サーバを呼び出し、返事をまつ

* `GenServer.cast`
    * 返事を必要としない（待ちたくない）ときにつかう
    * `handle_cast`に対応する

* `handle_cast`
    * 第1引数 : castに渡された引数
    * 第2引数 : 現在の状態

* `observer.start()`
    * サーバーモニタリングツール

## GenServerコールバック
* コールバック関数　https://hexdocs.pm/elixir/GenServer.html

## インターフェース
* アクション識別子を知っている必要があるため、インターフェースをラップすることが良い
```ex
def start_link(current_number) do
  GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
end
```

## 練習問題
* 練習問題1
    * server.handle_call/3 :pop
* 練習問題2
    * server.handle_cast/3 :push
* 練習問題3 # 省略
* 練習問題4
    * server.start_link/1 
    * server.pop/0
    * server.push/1 
* 練習問題5 # 省略

## 知見
* 実際に書くことでOTPが色々やってくれているというのを実感した。
* 抽象化されており、裏の挙動を完全に理解するのはもう少し理解が必要
* 使いながら覚えておきたい
