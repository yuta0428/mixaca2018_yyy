# モジュールと名前付き関数

##  モジュール
```hoge.ex
defmodule Hoge do
  def double(n) do
    n * 2
  end
  
  def double(n), do: n * 2  # こうも書ける

  defp fun(n), do n  # プライベート関数
end
```

## 名前付き関数でのパターンマッチ
* 上から試されていくので最初にマッチしたいものを上に書く（まあ当然）
    * 間違った順番だとコンパイルエラーで弾いてくれるってすごい
```ex
defmodule Factorial do  # nの階乗
  def of(0), do: 1
  def of(n), do: n * of(n-1)
end 
```

## ガード節
* 型、値によって関数を区別したい際に使う
* 詳細: http://elixir-ja.sena-net.works/getting_started/5.html#5.2-ガード句の中の式---expressions-in-guard-clauses.
```ex
defmodule Factorial do  # nの階乗
  def of(0), do: 1
  def of(n) when n > 0 do # 負の数が渡されないようにする
    n * of(n-1)
  end
end 
```

## デフォルトパラメータ
* 変数の後に`\\`で設定できる
  * C#と違って引数の一部だけにも設定できるぽい（C#だとデフォルト値のあとの引数にもデフォルト設定しないといけない）
* デフォルトパラメータで引数の数による呼び出しを制御できるが混乱を招きやすい
* そこで、デフォルトパラメータを含む関数のヘッドだけをボディなしで記述してその下に定義していくと良いらしい。（実際に見やすい）
```ex
defmodule Params do
  def func(p1, p2 \\ 123)

  def func(p1, p2) when is_list(p1) do
    # 処理
  end

  def func(p1, p2) do
    # 処理
  end
end
```

## パイプ演算子
* `|>`のように繋げると左式の結果を右式の第1引数に渡す
* コードの仕様をそのまま直感的に書けるという利点
  1. ~のjsonを得る
  1. パースする
  1. 必要なものを取り出す

## モジュールの読み込み
* `import`, `alias`, `require`
* どれもレキシカルスコープでの影響。（スコープ内で有効）
```ex
import Math only: [sum: 1],   # 必要な関数のみ読み込み出来る expect:もある アトムでまとめて読み込みも出来る
sum(4)  # importすると使用するモジュール名を記述しなくて良くなる

alias Math, as: M,   # モジュールのエイリアスを作る
M.sum(4)  # asで専用のエイリアスで呼べる。asしない場合最後の部分で呼べる

require Math # モジュールで定義したマクロを使いたい時に使う
```

## 属性
* `@`で定義される
* 関数内で定義できないが、アクセス可能
* 変数ではなく、定数的な扱いで使うもの



## 練習問題
* 練習問題1, 2, 3 簡単なので省略

* 練習問題4 再帰の実装
    * Math.exs sum/1

* 練習問題5 再帰の実装
    * Math.exs gcd/2

* 練習問題6 
    * chop.exs guess/2

## 知見
* 練習問題6解いたけど理解はしても自分で書くと難しかった。。。
* ガード節の設計が難しい
  * 引数のどの部分をガードした方が良いか悩む。