# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console, format: "[EXTRANS $level][$time] $message\n"

config :extrans,
  base_url: "http://HOSTNAME:9091/transmission/rpc/"