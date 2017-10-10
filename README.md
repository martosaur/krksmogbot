# Krksmogbot
[![Build Status](https://travis-ci.org/martosaur/krksmogbot.svg?branch=master)](https://travis-ci.org/martosaur/krksmogbot)

A [telegram bot](https://t.me/krksmogbot) that tells you how bad the air is in your area. It uses [Nadia](https://github.com/zhyu/nadia) telegram client and was heavily inspired by [this boilerplate](https://github.com/lubien/elixir-telegram-bot-boilerplate).

## Deploy

This bot uses [gigalixir](https://www.gigalixir.com/). With it installed create a new app:

```
gigalixir create
```

then set up `NADIA_BOT_TOKEN` (obtained from [@botfather](http://t.me/BotFather)) and `AIRLY_API_TOKEN` (see [airly](https://developer.airly.eu/)) for your app:

```
gigalixir set_config APP_NAME NADIA_BOT_TOKEN token_here
gigalixir set_config APP_NAME AIRLY_API_TOKEN token_here
```

add gigalixir remote:

```
gigalixir set_git_remote APP_NAME
```

and push code to master

```
git push gigalixir master
```

Deploy is done!