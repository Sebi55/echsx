defmodule Echsx.Http do
  @moduledoc """
   Responsible for managing HTTP requests to the ECHS OCHP API
  """

  alias Echsx.Config
  require Logger
  @headers [
    {"Content-type", "application/xml"},
    {"Accept", "application/xml"}
  ]

  @default_api_url "https://echs.e-clearing.net/service/ochp/v1.4"

  defp create_soap_header() do
    {:"soapenv:Header", nil, [
      {:"wsse:Security", ["xmlns:wsse": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd", "xmlns:wsu": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"], [
        {:"wsse:UsernameToken", nil, [
          {:"wsse:Username", nil, Config.get_env(:echsx, :username)},
          {:"wsse:Password", ["Type": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText"], Config.get_env(:echsx, :password)}
        ]}
      ]}
    ]}
  end

  defp handle_result(result) do
    case result do
      {:ok, data} -> {:ok, data}
      {:error, :invalid} -> {:error, [:invalid_api_response]}
      {:error, {:invalid, _reason}} -> {:error, [:invalid_api_response]}
      {:error, %{reason: reason}} -> {:error, [reason]}
    end
  end

  @spec get_charge_point_list_request(timeout: integer) :: {:ok, map} | {:error, [atom]}
  def get_charge_point_list_request(options \\ []) do
    timeout = options[:timeout] || Config.get_env(:echsx, :timeout, 5000)
    url = Config.get_env(:echsx, :api_url, @default_api_url)
    headers = @headers

    body = {:"soapenv:Envelope", ["xmlns:soapenv": "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns": "http://ochp.eu/1.4"], [
        create_soap_header(),
        {:"soapenv:Body", nil, [
          {:"ns:GetChargePointListRequest", nil, nil}
        ]}
      ]
    } |> XmlBuilder.generate(format: :none)

    Logger.info inspect body

    result =
      with {:ok, response} <-
            HTTPoison.post(url, body, headers, timeout: timeout),
          {:ok, data} <- response.body do
        {:ok, data}
      end

    Logger.info inspect result

    handle_result result
  end

  @spec get_charge_point_status_request(timeout: integer) :: {:ok, map} | {:error, [atom]}
  def get_charge_point_status_request(options \\ []) do
    timeout = options[:timeout] || Config.get_env(:echsx, :timeout, 5000)
    url = Config.get_env(:echsx, :api_url, @default_api_url)
    headers = @headers

    body = {:"soapenv:Envelope", ["xmlns:soapenv": "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns": "http://ochp.eu/1.4"], [
        create_soap_header(),
        {:"soapenv:Body", nil, [
          {:"OCHP:GetStatusRequest", nil, nil}
        ]}
      ]
    } |> XmlBuilder.generate(format: :none)

    Logger.info inspect body

    result =
      with {:ok, response} <-
            HTTPoison.post(url, body, headers, timeout: timeout),
          {:ok, data} <- response.body do
        {:ok, data}
      end

    Logger.info inspect result

    handle_result result
  end
end
