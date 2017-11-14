# OTP : スーパーバイザ
* プロセスの監視と再起動を執り行うプロセス
* 一つ以上のワーカープロセスを管理する
* 監視対象のプロセスが死んだときにどうするか、再起動ループをいかに防ぐかという指示を受け取る。

### Elxiirの流儀
* コードがクラッシュすることはあまり心配しないで、確実にアプリケーション全体が動き続けるようにすること。
* Elixirが大量のプロセスで構成されていることで、一つがクラッシュしても他は処理を進めることが出来るため。

## スーパーバイザの実装
* スーパーバイザはElang VMのプロセスリンクとモニタ機能を利用する。
* プロジェクト作成時`--sup`オプションでスーパーバイザを生成出来る。
* 実装しなくてはならないのは
    * 監視対象のプロセスのリストを渡す
    * プロセスが死んだときの振る舞い

### 監視対象のプロセスのリストを渡す
* `application.ex`内に記述
```application.ex
def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
        # worker関数を利用して、各プロセスが何を行うかの仕様を作る。
        worker(Sequence.Server, [123])
    ]
    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
end
```
処理の流れ
1. アプリケーション開始時に`Sequence.Application.start`が呼ばれる
1. 開始プロセス`Sequence.Server`, 引数`123`という仕様を子サーバリストに渡す
1. `Supervisor.start_link`が呼ばれ、スーパーバイザプロセスを作成
1. スーパーバイザプロセスが、監視対象の各子サーバで`start_link`関数を呼び出す。

今回だと
* `Sequence.Application.start` ➜  `Supervisor.start_link` ➜ `Sequence.Server.start_link` ➜ `GenServer.start_link`

### プロセスが死んだときの振る舞い
* プロセスが死ぬとスーパーバイザが再起動してくれるが、前回実行時の状態を保持していない
* ➜ 値を格納し取り出せる別個のワーカープロセスを用意する。（スタッシュ）
* スタッシュプロセス
    * sequenceサーバより長生きであること
    * sequenceサーバとは別の監視であること
```監視ツリー
トップレベルのスーパーバイザー
 ├── スタッシュワーカー
 └── サブスーパーバイザ
      └── Sequenceワーカー
```

* `Sequence.Supervisor`, `Sequence.SubSupervisor`, `Sequence.Stash`を作成し、スーパーバイザの開始を修正

処理の流れ
* トップレベルスーパーバイザにカウンタ初期値を渡して、子サーバー無しで開始
* スタッシュワーカーにカウンタ初期値を渡して開始
* サブスーパーバイザにスタッシュワーカーのPIDを渡して開始
* sequenceワーカーにスタッシュワーカーのPIDを渡して開始
    * Sequenceワーカーからスタッシュワーカーに値を送受するため

今回だと
* `Sequence.Application.start` ➜  `Sequence.Supervisor.start_link` ➜ `Sequence.Stash.start_link` ➜ `Sequence.SubSupervisor.start_link` ➜ `Sequence.Server.start_link` ➜ `GenServer.start_link`

また、
* sequenceワーカーの終了時にStashワーカーに現在の値を保存する。
* sequenceワーカーの起動時にStashワーカーから前回の値を取得する。

## スーパーバイザーは信頼の要
> _OTPが99.9999999%の信頼性をもつシステムを構築するために利用されてる_
by Joe Arnstring [_Programminng Erlang_]

OTPそのものの信頼性がものすごく高いということ。だと思う


## 練習問題
* 練習問題1 省略
* 練習問題2 Stackサーバーの監視ツリー化
    * 省略

## 知見
* 複数のプロセスを使ったプログラムの意図が分かってきた
    * というかElixirの大量にプロセスを作っていくプログラムの意味分かってきた
    * 状態とか個々をプロセスで管理していくことで構築していく感じ
* スーパーバイザとプロセスの関係が書くことで理解が深まった。