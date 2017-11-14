#---
# Excerpted from "Programming Elixir 1.2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir12 for more book information.
#---
defmodule Sequence.Server do
  use GenServer
  require Logger

  @vsn "1"
  defmodule State do
    defstruct current_number: 0, stash_pid: nil, delta: 1
  end

  #####
  # External API  

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end
  def next_number do
    with number = GenServer.call(__MODULE__, :next_number),
    do: "The number is #{number}"
  end
  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  #####
  # GenServer implementation

  def init(stash_pid) do
    state = Sequence.Stash.get_value stash_pid
    { :ok, state }
  end

  def handle_call(:next_number, _from, state) do 
    { :reply,
      state.current_number,
      %{ state | current_number: state.current_number + state.delta} }
  end

  def handle_cast({:increment_number, delta}, state) do
    {:noreply,
     %{ state | current_number: state.current_number + delta, delta: delta} }
  end

  def terminate(_reason, state) do
    Sequence.Stash.save_value state.stash_pid, state
  end
end
