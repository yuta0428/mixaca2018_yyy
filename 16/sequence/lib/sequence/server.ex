defmodule Sequence.Server do
  use GenServer  # GenServerというサーバーのビヘイビア コールバックを定義しなくて良いことになる

  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: __MODULE__)
  end

  def pop() do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  # クライアントがサーバーを呼び出すと、GenServerはhandle_callを呼び出す
  def handle_call(:next_number, _from, current_number) do
    # 次のhandle_call関数の呼び出し時のパラメータ
    {:reply, current_number, current_number+1 }
  end

  def handle_call(:pop, _from, [head|tail]) do
    # 次のhandle_call関数の呼び出し時のパラメータ
    {:reply, head, tail }
  end

  def handle_cast({:push, value}, list) do
    {:noreply, [value|list]}
  end

  def terminate(reason, state) do
    IO.puts "reason #{reason}, state #{state}"
  end
end
