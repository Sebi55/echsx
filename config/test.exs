use Mix.Config

config :echsx,
  http_client: Echsx.Http.MockClient,
  username: "test_user",
  password: "test_password"
