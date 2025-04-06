defmodule GlobalBackgroundJob.DatabaseCleaner do
  @moduledoc """
  The server that simulates the periodic task of deleting outdated data from a database
  """
  
  use GenServer
  require Logger

  alias __MODULE__.Runner

  @impl GenServer
  def init(args \\ []) do
    timeout = Keyword.get(args, :timeout)

    schedule(timeout)

    {:ok, timeout}
  end

  @impl GenServer
  def handle_info(:execute, timeout) do
    log("deleteing outdated records ...")

    Task.start(Runner, :execute, [])

    schedule(timeout)

    {:noreply, timeout}
  end

  defp schedule(timeout) do
    log("scheduling for #{timeout}ms...")

    Process.send_after(self(), :execute, timeout)
  end

  defp log(text) do
    Logger.info("----[#{node()} #{__MODULE__} #{text}")
  end
end