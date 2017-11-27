# プロトコル -- ポリモーフィック関数

## プロトコル
* 実装しなければならない関数を定義する
  * ビヘイビアに似ている
* 実装を完全にモジュール外に置くことが出来る点で違う

### プロトコルの定義
* （Inspectプロコトルの場合）
* モジュールのように実装できるが実装は別になる。
```ex
defprotocol Inspect do
  def inspect(thing, opts)
end
```

### プロコトルの実装
* `defimpl`マクロによって、一つ以上の型につていのプロコトルの実装を得ることが出来る
* （PID型についてのInspectプロコトルの実装）
```ex
defimpl Inspect, for: PID do
  def inspect(pid, _opts) do
    "#PID" <> IO.iodata_to_binary(pid_to_list(pid))
  end
end
```

* 実際にinspect.exをみると、それぞれの型について実装が定義されている
  * https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/inspect.ex#L63

## 利用可能な型
* `Any`, `atom`, `BifString`, `flost`, `Function`
* `Integer`, `List`, `Map`, `PID`, `Port`
* `Reference`, `Tuple`

* `Any`型はどんな型にもマッチする

## 組み込みプロトコル
* EnumerableとCollectable
  * https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/enum.ex
  * https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/collectable.ex
* Inspect
  * https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/inspect.ex
* List.Chars
  * https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/list/chars.ex
* String.Chars
  * https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/string/chars.ex

* それぞれのプロトコルの裏側の実装を解説していた

## プロトコルはポリモーフィック
* 引数の型によって異なる挙動となる関数を書く場合、ポリモーフィックな関数を実装すればよい
* Elixirのプロコトルはそのための機能を提供している


## 練習問題
* 練習問題1 
  * 解いたが分からなかった。。。
* 練習問題2 省略
* 練習問題3 省略
* 練習問題4 省略


## 知見
* 前章のビヘイビア（インタフェース）と来て、プロトコル（ポリモーフィック）と来たので、馴染みある実装方法で理解はしやすかった。
* ただ、分割の粒度の感覚が掴めていないので実際に使うことで覚えていきたい。
* 基底となる実装部分なので、実際の実装では設計のテクニックも必要になると感じた。
