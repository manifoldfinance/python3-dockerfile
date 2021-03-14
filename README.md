# Python3 Dockerfile

> deterministic python3.8 Dockerfile

## Motivation

Python3.8 Slim Image without unnecessary cruft, and include `pip` and `wheel` packages.

Differences from the official [Debian Python Image](https://github.com/docker-library/python/blob/master/3.8/buster/slim/Dockerfile)

- use multi-stage build in Dockerfile to ease the build process
- build Python3 without the modules:

* `ncurses`
* `readline`
* `tk`

- the Python3 interpreter is installed to `/python`

The Dockerfile uses `debian:buster-slim` (https://hub.docker.com/_/debian/)
as base but this is configurable at build time using `BASE_IMAGE_NAME`
as build argument.

## Testing

Tested with

- `debian:buster-slim`
- `debian:buster-slim`
- `ubuntu:18.04`,

## CI

- Hadolint

- Goss

## Building

````bash
docker build --tag python3:latest .

alternative base image:

```bash
    docker build --build-arg BASE_IMAGE_NAME=ubuntu:bionic --tag python3:bionic .
````

## Usage

By default, the Python interpreter is started when the image is ran:

```bash
    docker run --rm -it --name python3 python3:latest
```

To change this, just overwrite the `CMD` instruction in your Dockerfile.

## License

Apache-2.0
