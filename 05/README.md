# 無名関数

## 無名関数
* 名前のない関数
    * C#とかだと`() => {}`みたいに書くやつ。いわゆるラムダ式？
```ex
greet = fn -> IO.puts "Hello" end
greet.()   # Hello

sum = fn (a,b) -> a + b end
sum.(1,2)  # 3  ドット(.)で呼び出し
```

* 関数には複数のボディを持たせられる
* ↑とパターンマッチを組み合わせることで引数によって異なる実装を定義できる
    * ポリモーフィズムと違うのは引数の数は変えられないこと
```ex
handle_opne = fn
  {:ok, file} -> # File.openに成功したときの処理
  {_, error}  -> # File.openに失敗したときの処理
end
```

## &関数リテラル
* 無名関数の省略記法
```ex
greet = &(IO.puts "Hello")
greet.()   # Hello

sum = &(&1 + &2)
sum.(1,2)  # 3  ドット(.)で呼び出し
```

## 小技
* 引数に受け取ったマップのkeyとvalueを扱いたい時
```ex
fn {k, v} -> "Key = #{k}, Value = #{v}" end
```
* リストやタプル、マップで返すこともできる
```ex
&{1 + &1, 2 * &1}  
&[1 + &1, 2 * &1]
&%{1 + &1 => 2 * &1}
```

*　省略記法が名前付き関数の呼び出しと同じ場合、その関数を直接参照するように最適化されている。


## 練習問題
* 練習問題1 次の関数を作る
```ex
list_concat.([:a, :b], [:c, :d])  # [:a, :b, :c, :d]
sum.(1,2,3)                       # 6
pair_tuple_to_list.({1234, 5678}) # [1234, 5678]
```

```ex
list_concat = fn ([a, b], [c, d] ) -> [a, b] ++ [c, d] end
sum = fn (a, b, c) -> a+b+c end
pair_tuple_to_list = fn {a, b} -> [a, b] end
```

* 練習問題2 FizzBuzz　引数3つ
```ex
fizzbuzz3 = fn 
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, c) -> c
end
```

* 練習問題3　FizzBuzz　引数1つ
    * 問題内容がよくわからなかった
```ex
```

* 練習問題4 関数内関数（引数つき）を作成
```ex
prefix = fn s1 -> fn s2 -> IO.puts "#{s1} #{s2}" end end
```

* 練習問題5 書き換え
```ex
Enum.map [1,2,3,4], fn x -> x+2 end
Enum.each [1,2,3,4], fn x -> IO.inspect x end
```
```ex
Enum.map [1,2,3,4], &(&1+2)
Enum.each [1,2,3,4], &IO.inspect &1
```

## 知見
* 複数ボディとパターンマッチでの異なる処理の実装はとても強力だと感じた。ぜひ使っていきたい。
* 小技に書いたが、業務で詰まった部分を書いた。調べても中々出てこなかった。。。