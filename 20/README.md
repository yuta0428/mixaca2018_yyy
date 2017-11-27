# マクロとコードの評価

* メタプログラミング
  * 言語機能自体を拡張する機能
  * マクロやquote、unquoteがある
* （C++やExcelでいうマクロの感覚に近い認識）

## 用語
* 具体例は下に記述

### マクロ
* 遅延評価
  * 渡されたパラメータを評価せずに、代わりにそのコードを表現するタプルを引数として渡す

### quate関数
* ブロック単位で渡された内容を、そのブロックの内部表現として返す

### unquate関数
* マクロとquoteによって渡された内部表現を、評価した値として出力する。
* したがってunquoteはquoteブロック内でしか使えない

## ex) if文を作る
### 最終的な形
```ex
myif <<condition>> do
  <<evaluate if true>>
else
  <<evaluate if false>>
end
```

### 1. 普通に関数で実装
* https://github.com/yuta0428/mixaca2018_yyy/blob/elixir/20/myif_1.ex

実行結果
```
iex(1)> My.myif 1==2, do: (IO.puts "1==2"), else: (IO.puts "1!=2")
1==2
1!=2
:ok
```

* 引数に渡した`IO.puts "1==2"`, `IO.puts "1!=2"`が評価されてしまっている。
* 実際には`My.myif 1==2, do: :ok, else: :ok`が実行されてしまっている。

### 2. マクロで遅延評価させる
* 引数に渡す`IO.puts `が評価されないように`myif`をマクロ定義に変更
* `condition`と`clauses`を出力
* https://github.com/yuta0428/mixaca2018_yyy/blob/elixir/20/myif_2.ex

実行結果
```
$ iex "20/myif_2.ex"

condition
{:==, [line: 13], [1, 2]}
clauses
[do: {{:., [line: 13], [{:__aliases__, [counter: 0, line: 13], [:IO]}, :puts]},
  [line: 13], ["1==2"]},
else: {{:., [line: 13],
  [{:__aliases__, [counter: 0, line: 13], [:IO]}, :puts]}, [line: 13],
  ["1!=2"]}]
1==2
1!=2
```

* パラメータの値はマクロにより内部表現で渡されている
* よく分かっていないが、内部表現をそのまま実行すると、その評価結果を返してくれる
  * そのため、`do_clause`は`IO.puts "1==2"`を`else_clause`は`IO.puts "1!=2"`出力する。

### 3. `case`句できちんと評価されるように、quote関数でブロックを受けて、unquoteで評価させる。
* https://github.com/yuta0428/mixaca2018_yyy/blob/elixir/20/myif_3.ex

実行結果
```
1!=2
```

## バインディング
* quoteのブロックに値を注入する方法のうちの１つ
* 単なる変数名と値のキーワードリスト
* quoteにバインディングを渡すと、quoteのボディの中の変数がセットされる

引数で渡した名前を関数名とし、その名前を返す関数を定義するマクロ
```ex 
defmacro mydef(name) do
  quote do
    def unquote(name)(), do: unquote(name)  # def unquote(name)が関数名定義
  end
end
```

quoteブロックで渡された値を利用可能にする
```ex
defmacro mydef(name) do
  quote binf_quote: [name: name] do
    def unquote(name)(), do: unquote(name)  # def unquote(name)が関数名定義
  end
end
```

* 両者の違いは、unquoteが実行されるまでnameの値が評価されるかされないか
* https://elixirschool.com/jp/lessons/advanced/metaprogramming/#binding


## マクロは健全
* マクロはテキストとして展開さえr、呼んだ場所でコンパイルされるわけではない。
* マクロは自分自身のスコープとquoteしたマジュロのボデイのスコープを持つ
  * マクロは他の変数や関数の変数を壊したり（上書きしたりしない）

## マクロと演算子
* マクロを使って演算子をオーバーライドすることが出来る
* しかし、既存の定義を消去する必要があるため、非常に危険。

## 練習問題
* 練習問題1 unlessバージョン
  * myunless.ex
* 練習問題2  times_nというマクロ
  * times_n.ex
* 練習問題3 省略

## 知見
* マクロの扱い方について知ることが出来た。
* 説明の部分はほんの内奥を自分なりに流れで解釈してみたが、解釈として正しいか不安。
* ExUnitなどでも使われているテクニックとのことなので、知識として覚えておきたい。
