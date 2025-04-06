defmodule GlobalBackgroundJob.DatabaseCleaner.Runner do
  @moduledoc """
  Module which emulates the database cleaner job by sleeping for a random
  time corresponding to the number of records deleted
  """
  require Logger

  def execute do
    random = :rand.uniform(1_000)

    Process.sleep(random)

    Logger.info("#{__MODULE__} #{random} records deleted.")
  end
end