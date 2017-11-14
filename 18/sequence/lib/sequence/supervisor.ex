defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_number])
    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    import Supervisor.Spec, warn: false
    # スタッシュワーカーとサブスーパーバイザを手動でトップレベルスーパーバイザに追加
    # スタッシュワーカーを開始
    {:ok, stash} = Supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
    # そして実際のsequenceサーバのスーパーバイザを開始
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end