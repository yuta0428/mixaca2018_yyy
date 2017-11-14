# OTP : アプリケーション
* OTPの世界(Erlangの世界)ではアプリケーションは、ディスクリプタでひとまとめにされたコードの一式。
* 動的リンクライブラリや共有オブジェクトに似ている

## OTPアプリケーションの作成
* `mix`でプロジェクト作成時に、`mix.exs`のapllication関数にトップモジュールレベルの情報が入る。
* このモジュールがstart関数を実装していると想定し、空のリストをパラメータとして渡している。
```mix.exs
  def application do
    [ mod: {Sequence.Application, []} ]
  end
```

#### 空のリストの代わりに`mix.exs`から値を渡す
```mix.exs
  def application do
    [ mod: {Sequence.Application, 456} ]
  end
```
```applicaiton.exs
  def start(_type, initial_number) do
    {:ok, _pid} = Sequence.Supervisor.start_link(initial_number)
  end
```

#### `registered:`オプションで、登録する予定の名前がユニークであることを保証する
```mix.exs
  def application do
    [ 
      mod: {Sequence.Application, 456},
      registered: [Sequence.Server]
    ]
  end
```

#### キーワードリストでアプリケーションパラメータを渡す
* `Applicaiton.get_env`が提供されているから
  * `env:`で指定した値を取り出す
```mix.exs
  def application do
    [ 
      mod: {Sequence.Application, []},
      env: [initial_number: 456],
      registered: [Sequence.Server]
    ]
  end
```
```applicaiton.exs
  def start(_type, _args) do
    # トップレベルスーパーバイザを子サーバー無しで作成
    {:ok, _pid} = Sequence.Supervisor.start_link(Application.get_env(:sequence, :initial_number))
  end
```

# コードのリリース
* Erlangの信頼性を実現しているものの一つに、堅固なリリース管理システムがある。
* EXRMというリリースマネージャが実装されている。

|用語|コマンド|意味|
|:-:|:-:|:-:|
|リリース（release）|`mix release`|アプリケーションの依存関係や設定など全てを束ねたもの 。`rel/**/releases/x.x.x/*.tar.gx`がサーバーにデプロイされる|
|デプロイ（deployment）|| あるリリースをそれが動く環境に配置すること|
|ホットアップグレード（hot upgrade）|`upgrade`|デプロイの一種。実行中のアプリケーションを止めることなく更新する。|

* exrmの依存関係を追加する必要がある。
```mix.exs
  defp deps do
    [
      {:exrm, "~> 1.0.0-rc7"},
    ]
  end
```

### バージョン付け
* Elixirではアプリケーションコードと、それが操作するデータの両方にバージョンを付ける。

#### アプリケーションコードのバージョンセット
* `upgrade`コマンドでサーバを止めることなく更新ができる。
```mix.exs
  def project do
    [
      app: :sequence,
      # version: "0.1.0",　
      version: "0.2.0",
      deps: deps()
    ]
  end
```
* Erlangは同時に2つのモジュールを実行することが出来る。
* そのため、変更されたモジュールが参照されるまで、古いバージョンのコードを使い続け、参照されたら新しいバージョンにスワップする。

#### 状態のデータのバージョンセット
* `@vsn`（version）ディレクティブを使う
```server.ex
defmodule Sequence.Server do
  use GenServer

  @vsn "0"
```

* 古いサーバの状態と新しいサーバの状態が違う場合、新旧サーバの値をコピーすることはできないが、
* OTPの`code_change`コールバックを使用することで、新しいサーバへ状態を引き継ぐことが出来る。
  * 第1引数: 古いバージョン番号
  * 第2引数: 古い状態
  * 第3引数: 新しいパラメータ
```server.ex
  def code_change("0", old_state = { current_number, stash_pid }, _extra) do
    new_state = %State{current_number: current_number, 
                       stash_pid: stash_pid,
                       delta: 1
                      }
    { :ok, new_state }
  end
```


## 練習問題
* 練習問題1 StackサーバーのOTPアプリケーション化
  * 省略
* 練習問題2 省略
* 練習問題3 差分もスタッシュサーバーに保存する
  * 解いたが分からなかった。。。
  * スタッシュワーカーが先に起動されるので、スタッシュワーカー側に最初にcurrrent_numberが保存されてしまうのをどうしたら良いのか分からない。。

## 知見
* 実際にホットアップデートでプロセスを止めずに行うのを確認して、少し感動した。
* 非常に簡単（と思っているだけだが）にリリース、デプロイが出、OTPの凄さを実感した。
* まだまだOTPの一部ということだが、重要な機能を意識して覚えていきたい。