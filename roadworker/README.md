Docker image for [Roadworker](https://github.com/codenize-tools/roadworker)

- based on [ruby:alpine](https://hub.docker.com/_/ruby/)
- roadworker installed with gem

## usage

### export

```console
docker run -it --rm -v ${PWD}:/work yokogawa/roadworker roadworker -e -o Routefile
```

### test

```console
docker run -it --rm -v ${PWD}:/work yokogawa/roadworker roadworker -t
```

### dry-run

```console
docker run -it --rm -v ${PWD}:/work yokogawa/roadworker roadworker -a --dry-run
```

### apply

```console
docker run -it --rm -v ${PWD}:/work yokogawa/roadworker roadworker -a
```

## Credentials

FIXME
