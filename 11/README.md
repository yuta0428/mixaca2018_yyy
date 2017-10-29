# 文字列とバイナリ

* `""`と`''`でくくる2種類の文字列がある。
    * `""`は文字列
    * `''`は文字コードのリスト
* どちらも複数行可能
* 文字列はバイナリである
* Stringモジュール : https://hexdocs.pm/elixir/String.html

## シジル(_Sigil_)
* * `~...`というスタイルの文法
* 色々タイプがある : http://elixir-ja.sena-net.works/getting_started/19.html#19.1-正規表現---regular-expressions

## バイナリとパターンマッチ
* 型 `binary`, `bits`, `bitstring`, `bytes`, `float`, `integer`, `utf8`, `utf16`, `utf32`
* `size(n)` : フィールドのビット数
* `signed`, `unsigned` : 整数フィールドに対して、符号付きかどうか
* エンディアン(endian) : `big`, `little`, `native`
```ex
def  each(<<head :: utf8, tail :: binary>>), do: #  ヘッドがutf8、ているがバイナリのパターンマッチ
```


## 練習問題
* 練習問題1,2,3,4 # 空き時間に

* 練習問題5 # 空き時間に

* 練習問題6,7 # 空き時間に


## 知見
* 文字列と文字コードのリストがあることを知っていないと、ふいに出力時に数字が出てきて戸惑うことがあった。
* バイナリあたりは苦手な領域なので、扱うときに再度深く理解したい。