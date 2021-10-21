defmodule Echsx do
  @moduledoc """
    A wrapper module for the ECHS OCHP API.
  """

  alias Echsx.{Http}

  @http_client Application.get_env(:echsx, :http_client, Http)

  def get_charge_point_list_request(options \\ []) do

    response =
      @http_client.create_device_env_variable(
        request_body(),
        Keyword.take(options, [:timeout])
      )

    case device do
      {:error, errors} ->
        {:error, errors}
      {:ok, %{"d" => []}} ->
        {:error, %{error: "No device found"}}
      {:ok, "Unique key constraint violated"} ->
        {:error, %{error: "Unique key constraint violated"}}
      {:ok, data} ->
        {:ok, data}
    end
  end

  defp request_body(body) do
    body
    |> URI.encode_query()
  end

end
