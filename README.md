# Hackathon

Check dockerhub for an image for the latest build of this thing


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add workspace to your list of dependencies in `mix.exs`:

        def deps do
          [{:workspace, "~> 0.0.1"}]
        end

  2. Ensure workspace is started before your application:

        def application do
          [applications: [:workspace]]
        end

