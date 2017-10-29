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

## 練習問題
練習問題0 アキュムレータ(変数total)なし
* mylist.exs sum/1

練習問題1,2,3 時間のある時

## 知見
* 実際はListモジュールで足りてしまう部分だが、自分で書いてみることでより理解が深まった