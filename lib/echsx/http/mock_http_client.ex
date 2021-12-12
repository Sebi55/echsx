defmodule Echsx.Http.MockClient do
  @moduledoc """
    A mock HTTP client used for testing.
  """
  alias Echsx.Http

  # every other match is a pass through to the real client
  def get_charge_point_list_request(options) do
    send(self(), {:get_charge_point_list_request, options})
    Http.get_charge_point_list_request(options)
  end

  # every other match is a pass through to the real client
  def get_charge_point_status_request(options) do
    send(self(), {:get_charge_point_status_request, options})
    Http.get_charge_point_status_request(options)
  end

  # every other match is a pass through to the real client
  def get_charge_point_status_request(parking_spot_id, status, options) do
    send(self(), {:get_charge_point_status_request, parking_spot_id, status, options})
    Http.get_charge_point_status_request(parking_spot_id, status, options)
  end
end
