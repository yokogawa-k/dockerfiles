Docker image for [awspec](https://github.com/k1LoW/awspec)

- based on [ruby:alpine](https://hub.docker.com/_/ruby/)
- awspec installed with gem

## usage

### init

```console
docker run -it --rm -v ${PWD}:/work yokogawa/awspec awspec init
```

### configure

```console
docker run -it --rm -v ${PWD}:/work yokogawa/awspec awspec configure
```

### Run tests

```console
docker run -it --rm -v ${PWD}:/work yokogawa/awspec bundle exec rake spec
```

### generate

```console
docker run -it --rm -v ${PWD}:/work yokogawa/awspec awspec generate ec2 vpc-ab123cde >>ec2_spec.rb
```

