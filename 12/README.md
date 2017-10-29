# 制御フロー

## ifとunless
* 書き方に多言語と特別な違いない
* `elseif`がない！Elixrでは`cond`で代用する
```ex
if 1 == 1, do: "true part", else: "false part"
```
```ex
unless 1 == 1, do: "true part", else: "false part"
```

## cond
* 多言語の`if..elseif..else`構文(?)
```ex
def fizzbuzz(n) do
  ans = 
    cond do
      rem(n, 3)==0 and rem(n, 5)==0 ->  "FizzBuzz
      rem(n, 3)==0 ->  "Fizz"
      rem(n, 5)==0 ->  "Buzz"
      true -> n  # elseの代わり
    end
end
```

## case
* 多言語のswitch文のパターンマッチバージョン
* 最初にマッチしたコードを実行する
```ex
case File.open("Hogefile") do
  {:ok, file} ->       # 成功時の処理
  {:error, reason} ->  # 失敗時の処理
end
```
* ガード節を含めることが出来る
```ex
dave = %{name: "Dave", age: 27}
case dave do
  person = %{age: age} when age>=21 ->  # キーが存在し、ガード節をクリアしたときの処理
  ->                                    # それ以外の処理
end
```

## Elixirでの例外
* Elixirの例外は制御構造でない
* サーバーから応答がないなど通常操作で起こるはずのないことが、例外に値する。
* ユーザーの入力ミスで開けないなど（予測可能）なことは、例外とみなせない。
* 関数名の末尾に`!`があるとこの関数はエラー時に意味のある例外を発生させるものと分かる。

## 練習問題
練習問題 1 FizzBuzz 

練習問題 2 FizzBuzz

練習問題 3 FizzBuzz


## 知見
* 制御構文、例外は確実に使っていくので覚えておきたい
* 記法は特に難はないが、パターンマッチやガード節を組み合わせた実装を意識していきたい。

