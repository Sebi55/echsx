defmodule Echsx do
  @moduledoc """
    A wrapper module for the ECHS OCHP API.
  """

  alias Echsx.{Http}

  @http_client Application.get_env(:echsx, :http_client, Http)

  def get_charge_point_list_request(options \\ []) do

    @http_client.get_charge_point_list(
      Keyword.take(options, [:timeout])
    )
  end

end
