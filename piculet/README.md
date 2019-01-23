Docker image for [Piculet](https://github.com/codenize-tools/piculet).

- based on [ruby:alpine](https://hub.docker.com/_/ruby/)
- piculet installed with gem

## usage

### export

```console
docker run -it --rm -v ${PWD}:/work yokogawa/piculet piculet -e -o Groupfile
```

### dry-run

```console
docker run -it --rm -v ${PWD}:/work yokogawa/piculet piculet -a --dry-run
```

### apply

```console
docker run -it --rm -v ${PWD}:/work yokogawa/piculet piculet -a
```

## Credentials

FIXME
