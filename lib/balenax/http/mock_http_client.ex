defmodule Echsx.Http.MockClient do
  @moduledoc """
    A mock HTTP client used for testing.
  """
  alias Echsx.Http

  # every other match is a pass through to the real client
  def get_charge_point_list(options) do
    send(self(), {:get_charge_point_list, options})
    Http.get_charge_point_list(options)
  end

  # every other match is a pass through to the real client
  def get_charge_point_status(options) do
    send(self(), {:get_charge_point_status, options})
    Http.get_charge_point_status(options)
  end
end
