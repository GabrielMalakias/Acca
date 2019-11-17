FROM elixir:1.9.0-alpine
WORKDIR /opt/acca_worker

ENV MIX_ENV prod

RUN mix local.hex --force && mix local.rebar --force

COPY mix.* ./

RUN mix deps.get --only prod

RUN mix deps.compile

COPY . .

RUN mix compile

CMD ./scripts/docker.sh
