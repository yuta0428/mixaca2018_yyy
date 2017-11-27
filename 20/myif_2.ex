defmodule My do
  defmacro if(condition, clauses) do
    IO.puts "condition"
    IO.inspect condition
    IO.puts "clauses"
    IO.inspect clauses
  end
end


defmodule Test do
  require My
  My.if 1==2, do: (IO.puts "1==2"), else: (IO.puts "1!=2")
end