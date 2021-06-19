FROM hexpm/elixir:1.12.0-erlang-23.3.4.4-alpine-3.13.3 as builder

RUN apk add --update alpine-sdk

ENV MIX_ENV="prod"

WORKDIR /opt/build

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY rel rel
COPY lib lib
RUN mix release

# DONE BUILDING
# NOW MAKE THE DELIVERY IMAGE

FROM alpine:3.13.3
RUN apk add --update ncurses ncurses-libs
ENV MIX_ENV="prod"

WORKDIR /credo
COPY --from=builder /opt/build/_build/prod/rel/bakeware ./
RUN mkdir -p /root/.cache/bakeware/.tmp

ENTRYPOINT ["./credo_standalone"]
