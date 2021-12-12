defmodule Echsx do
  @moduledoc """
    A wrapper module for the ECHS OCHP API.
  """

  alias Echsx.{Http}

  @http_client Application.get_env(:echsx, :http_client, Http)

  def get_charge_point_list(options \\ []) do
    @http_client.get_charge_point_list_request(
      Keyword.take(options, [:timeout])
    )
  end

  def get_charge_point_status(options \\ []) do
    @http_client.get_charge_point_status_request(
      Keyword.take(options, [:timeout])
    )
  end

  def update_charge_point_sensor_status(parking_spot_id, status, options \\ []) do
    @http_client.update_charge_point_sensor_status_request(
      parking_spot_id, status, Keyword.take(options, [:timeout])
    )
  end

end
