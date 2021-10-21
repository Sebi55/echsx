defmodule Balenax.Http.MockClient do
  @moduledoc """
    A mock HTTP client used for testing.
  """
  alias Balenax.Http

  # every other match is a pass through to the real client
  def get_device_by_uuid(balena_uuid, options) do
    send(self(), {:get_device_by_uuid, balena_uuid, options})
    Http.get_device_by_uuid(balena_uuid, options)
  end

  # every other match is a pass through to the real client
  def get_device_by_id(balena_id, options) do
    send(self(), {:get_device_by_id, balena_id, options})
    Http.get_device_by_uuid(balena_id, options)
  end

  # every other match is a pass through to the real client
  def create_device_env_variable(body, options) do
    send(self(), {:create_device_env_variable, body, options})
    Http.create_device_env_variable(body, options)
  end
end
