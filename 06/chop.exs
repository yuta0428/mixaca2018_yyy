defmodule Chop do
  def guess(actual, range) 

  def guess(actual, a..b) do
    guess(actual, a..b, div(a+b, 2))
  end

  def guess(actual, a..b, pred) when actual == pred do
    IO.puts "Is it #{pred}"
    pred
  end

  def guess(actual, a..b, pred) when actual < pred do
    IO.puts "Is it #{pred}"
    guess(actual, a..pred-1)
  end

  def guess(actual, a..b, pred) when actual > pred do
    IO.puts "Is it #{pred}"
    guess(actual, pred+1..b)
  end
end