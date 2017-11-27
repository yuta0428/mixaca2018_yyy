# モジュールのリンクとビヘイビアとuse

## ビヘイビア
* ビヘイビアを実装すると宣言したモジュールは、関連する全ての関数を実装する必要がある
  * JavaやC#のインタフェースのようなもの
* `GenServer`などのこと

### ビヘイビアの定義
  * `@callback` を使ってビヘイビアを定義する。

### ビヘイビアの宣言
  * `@behaviour モジュール名`で実装すr事を宣言できる。

### useと__using__
* GenServerの際は`use GenServer`と記述した。
* `use`はマクロであり、`__using__/1`を特定のモジュールから呼び出す。
  * したがって、GetServerの`__using__/1`内では`@behaviour GenServer`が呼び出されている。
* https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/gen_server.ex#L569
```elixir/blob/master/lib/elixir/lib/gen_server.ex
defmacro __using__(opts) do
  quote location: :keep do
      @behaviour GenServer
```

## 練習問題
* 練習問題1 省略
* 練習問題2 省略
* 練習問題3 省略

## 知見
* ビヘイビアについて、改めて理解することが出来た。
* これまで、`use`でビヘイビアを使うことができるようになるという理解だったが、`use`はマクロ、内部で`__using__/1`が呼ばれている等知ることが出来た。
* インタフェースと考えると、実際に実装する際も細かくビヘイビアに処理を分割することになるのかと感じた。