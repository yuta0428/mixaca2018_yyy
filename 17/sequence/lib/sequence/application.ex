defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # トップレベルスーパーバイザを子サーバー無しで作成
    {:ok, _pid} = Sequence.Supervisor.start_link(123)
  end
end
