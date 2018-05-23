# docker-arch-pkgbuild

Build your Arch Linux packages within a Docker container.

## Usage

```
docker pull flaccid/arch-makepkg
docker run -i -t --rm -v $(pwd):/usr/local/build/src flaccid/arch-makepkg
```
