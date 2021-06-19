defmodule CredoStandalone.Main do
  @moduledoc """
  Just a wrapper to add the Bakeware magic to credo's entrypoint function
  """
  use Bakeware.Script

  @impl Bakeware.Script
  @spec main([binary]) :: 0
  def main(args) do
    Credo.CLI.main(["--mute-exit-status" | args])
    0
  end
end
