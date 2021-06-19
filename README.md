# CredoStandalone

An experiment in deploying a standalone version of [Credo](https://github.com/rrrene/credo) using [Bakeware](https://github.com/bake-bake-bake/bakeware) for portability. The target use case is for things like automated linters that need to run outside of the context of the Elixir code they're linting, particularly multi-lingual tools like [GitHub's super-linter](https://github.com/github/super-linter).


## Building
```
export MIX_ENV=prod
mix deps.get
mix release
```

The `mix release` command will generate _two_ outputs. A standard elixir release at `_build/prod/rel/credo_standalone/...` and a portable binary at `_build/prod/rel/bakeware/credo_standalone`. The portable executable does require a linux-like system and an ncurses installation to work, so it's not 100% portable but could be useful in things like CI pipelines.

Because this standalone version of credo won't be in your mix project, it's most useful with the `--read-from-stdin` argument, like
```
./_build/prod/rel/bakeware/credo_standalone --format=oneline --read-from-stdin < ./lib/main.ex
```

The included `Dockerfile` builds and packages this executable in a docker image for more portability and potentially easier distribution into other docker images.
```
docker build -t credo:test .
docker run -i credo:test --format=oneline --read-from-stdin < ./lib/main.ex
```
