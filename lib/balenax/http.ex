defmodule Balenax.Http do
  @moduledoc """
   Responsible for managing HTTP requests to the balena API
  """

  alias Balenax.Config
  require Logger
  @headers [
    {"Content-type", "application/xml"},
    {"Accept", "application/xml"}
  ]

  @default_api_url "https://echs.e-clearing.net/service/ochp/v1.4"

  @spec get_charge_point_list_request(timeout: integer) ::
          {:ok, map} | {:error, [atom]}
  def get_charge_point_list_request(body, options \\ []) do
    timeout = options[:timeout] || Config.get_env(:balenax, :timeout, 5000)
    url = Config.get_env(:balenax, :api_url, @default_api_url)
    headers = @headers


  #   """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://ochp.eu/1.4">
  #   <soapenv:Header>
  #     <wsse:Security soapenv:mustUnderstand="1" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
  #       <wsse:UsernameToken>
  #         <wsse:Username></wsse:Username>
  #         <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText"></wsse:Password>
  #       </wsse:UsernameToken>
  #     </wsse:Security>
  #   </soapenv:Header>
  #    <soapenv:Body>
  #       <ns:GetChargePointListRequest/>
  #    </soapenv:Body>
  # </soapenv:Envelope>
  #   """

    body = {:"soapenv:Envelope", ["xmlns:soapenv": "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns": "http://ochp.eu/1.4"], [
        {:"soapenv:Header", nil, [
          {:"wsse:Security", ["xmlns:wsse": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd", "xmlns:wsu": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"], [
            {:"wsse:UsernameToken", nil, [
              {:"wsse:Username", nil, Config.get_env(:echsx, :username)},
              {:"wsse:Password", ["Type": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText"], Config.get_env(:echsx, :password)}
            ]}
          ]}
        ]},
        {:reference, nil, id},
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
    case result do
      {:ok, data} -> {:ok, data}
      {:error, :invalid} -> {:error, [:invalid_api_response]}
      {:error, {:invalid, _reason}} -> {:error, [:invalid_api_response]}
      {:error, %{reason: reason}} -> {:error, [reason]}
    end
  end
end
