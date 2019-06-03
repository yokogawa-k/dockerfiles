Docker image for [Cfdef](https://github.com/codenize-tools/cfdef).

- based on [ruby:alpine](https://hub.docker.com/_/ruby/)
- cfdef installed with gem

## usage

### export

```console
docker run -it --rm -v ${PWD}:/work yokogawa/cfdef -e -o CFfile
```

### dry-run

```console
docker run -it --rm -v ${PWD}:/work yokogawa/cfdef -a --dry-run
```

### apply

```console
docker run -it --rm -v ${PWD}:/work yokogawa/cfdef -a
```

