# Krksmogbot
A [telegram bot](https://t.me/krksmogbot) that tells you how bad the air is in your area. It uses [Nadia](https://github.com/zhyu/nadia) telegram client and was heavily inspired by [this boilerplate](https://github.com/lubien/elixir-telegram-bot-boilerplate).

## Development

1. Checkout repo
2. Make sure to install Elixir 1.9.0 or higher
3. Create a `config/dev.ex`
4. Populate config file with a bot token (obtained from [@botfather](http://t.me/BotFather)) and airly api token (see [airly](https://developer.airly.eu/)
5. `mix run --no-halt` will start application

## Deploy

This bot is meant to be deployed using [Elixir releases](https://hexdocs.pm/mix/Mix.Tasks.Release.html)

There is a dockerfile that would help you assembling a release for ubuntu 18.04. Simply run `build_ubuntu_release.sh` and it will create release in `_build/ubuntu`