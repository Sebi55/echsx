# Echsx

[![Hex.pm](https://img.shields.io/badge/Hex-v2.1.1-green.svg)](https://hexdocs.pm/echsx)

An Elixir wrapper package for the ECHS OCHP API [OCHP].

[OCHP]: https://github.com/e-clearing-net/OCHP

### Important Notice
The package is in active development. Only the API endpoints needed for the development of PlantGuru are in active development. Please feel free to extend or improve this package with PRs at any time. I am happy to merge all compatible PRs.

## Installation

1. Add echsx to your `mix.exs` dependencies

```elixir
  defp deps do
    [
      {:echsx, "~> 0.0.1"},
    ]
  end
```

2. List `:echsx` as an application dependency

```elixir
  def application do
    [ extra_applications: [:echsx] ]
  end
```

3. Run `mix do deps.get, compile`

## Config

By default the authentication credentials are loaded via the environment variables.

```elixir
  config :echsx,
    username: {:system, "ECHS_USERNAME"},
    password: {:system, "ECHS_PASSWORD"}

```

## Usage

### API

Echsx provides the `get_charge_point_list_request/1` method. Below is an example using a Phoenix controller action:

```elixir
  def get(conn, params) do
    case Echsx.get_charge_point_list_request() do
      {:ok, response} -> do_something
      {:error, errors} -> handle_error
    end
  end
```

`get_charge_point_list_request` method sends a `POST` request to the ECHS API.

## Contributing

Check out [CONTRIBUTING.md](/CONTRIBUTING.md) if you want to help.

## License

[MIT License](http://www.opensource.org/licenses/MIT).
