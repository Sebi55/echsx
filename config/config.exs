use Mix.Config

config :echsx,
  api_url: "https://echs.e-clearing.net/service/ochp/v1.4",
  live_api_url: "https://echs.e-clearing.net/live/ochp/v1.4",
  username: {:system, "ECHS_USERNAME"},
  password: {:system, "ECHS_PASSWORD"},
  timeout: 5000

import_config "#{Mix.env()}.exs"
