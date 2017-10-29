# リストと再帰
* リストはヘッドとテイルで構成される `[head | [tail]]`
* パターンマッチでヘッドとテイルで分割できる
```ex
def len([head | tail]), do:  # 処理
```

* 再帰への応用
* ヘルパー関数にはパブリック関数と関連づいたものだと分かるように`_`or`do_`を付けるとよい
```ex
def sum(list), do: _sum(list, 0)
defp _sum([], total),            do: total
defp _sum([head | tail], total), do: _sum(tail, head+total)
```

* Listモジュール: https://hexdocs.pm/elixir/List.html


# マップ、キーワードリスト、セット、構造体

* 簡単に分けると。。。
    * 内容についてパターンマッチをしたい　➜　マップ
    * 同じキーを持ちたい ➜ キーワードリスト
    * 要素の順番を保証したい ➜ キーワードリスト
    * それ以外 ➜ マップ

## マップ
* パターンマッチ
```ex
person = %{name: "Dave", height: 100}
%{name: a} = person  # :nameをキーとするエントリーがあるかマッチ
%{name: _, height: _} = person  # :nameと:heightをキーとするエントリーがあるかマッチ
%{name: "Dave"} = person  # :nameをキーのエントリー値は"Dave"か
```

* 値更新
```ex
new_map = %{old_map | key => value, ...}
```

* 構造体
    * モジュールの属性を定義する。（プロパティ値的な）
```ex
defmodule Customer do
  defstruct name: "", company: ""
end

customer = %Customer{name: "Dave"}
customer.name  # ドット記法でアクセス
```

# コレクションの処理--EnumとStream

* Elixirにはコレクションを操作する`Enum`と`Stream`モジュールがある
* Enumはコレクションへの操作をもつ
* Streamはコレクションの列挙を遅延させる

* Enum https://hexdocs.pm/elixir/Enum.html
* Stream https://hexdocs.pm/elixir/Stream.html

### 個人的に
* Enum系を本当によく使うが、基本List`[]`で返ってくるので、マップに変換したいときや、入れ子にしてほしくない時に詰まる
* そんな時は`Enum.reduce(enumerable, acc, fun)`が良い
    * `acc`に`%{}`を渡すことで、目的の型にしやすい

## Stream
* Enumはコレクションを返す処理のため、ファイル読み込みなど大きなリストを作成し操作する場合は最適ではない
    * 大体の場合でしたいことは読み込んだ内容に対して操作した結果なので、中間のリストはいらない。
```ex
IO.puts File.read!("HogeFile")
        |> String.split
        |> Enum.max_by(&String.length/1)
```
* Streamは組み立て可能な列挙子(_enumerator_)のため、リストを返すのではなく意図した仕様を返す
* StreamにStreamを渡して最終的にリストにすることで中間リストを作らない
```ex
IO.puts File.read!("HogeFile")
        |> IO.stream(:line)     # 一行ずつストリームに変換する
        |> Enum.max_by(&String.length/1)
```

## 内包表記
* for のワンライナー構文
* mapやfilterの代わりに書けることが多いので、mapを使う前に一考する価値あり
```ex
for x <- [1, 2, 3, 4], do: x*x        # [1, 4, 9, 16]
for x <- [1, 2, 3, 4], x < 4 do: x*x  # [1, 4, 9]
```

* 返り値を`into:`パラメータで買えることが出来る
```ex
for x <- ~w{cat dog}, into: %{}, do: {x, String.upcase(x)}  # %{"cat" => "CAT", "dog" => "DOG"}
```

* メリット: 中間結果を保存しなくて良い。データ読み込みなど到着次第処理を始めることが出来る
* デメリット: 実行速度が2倍遅い

## 神業との訣別
* _実際には、ほとんどの日常の仕事はElixirに組み込まれた様々な列挙師でやったほうがうまくいく。列挙子はコードを短く、わかりやすく、効率的にする。_
* _再帰使うべきところか、列挙子を使うべき所かを自分で判断してみることだ。できることなら列挙師を使うことをおすすめする。_

## 練習問題
練習問題0 アキュムレータ(変数total)なし
* mylist.exs sum/1

練習問題1,2,3,4  # 時間のある時

練習問題5 `all?, each, filter, split, take`を実装
* MyEnum.exs  # 空き時間に

練習問題6 flattenを実装
* MyEnum.exs  # 空き時間に

練習問題7 練習問題4をリスト内包表記で  # 時間のある時

練習問題8  # 空き時間に


## 知見
* 実際はListモジュールで足りてしまう部分だが、自分で書いてみることでより理解が深まった
* マップのパターンマッチの使い方も忘れないようにしたい
* Enum.mapに頼りやすいので、読みやすさも考えて必要な所でリスト内包表記を使っていきたい。
