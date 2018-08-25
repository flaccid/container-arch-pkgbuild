# docker-arch-pkgbuild

Build your Arch Linux packages within a Docker container.

## Usage

```
docker pull flaccid/arch-makepkg
docker run -i -t --rm -v $(pwd):/usr/local/build/src flaccid/arch-makepkg
```

If you get the following:

```
==> ERROR: You do not have write permission to create packages in /usr/local/build/src.
    Aborting...

==> ERROR: An unknown error has occurred. Exiting...
```

You probably have not provided a bind mount volume to this location with a `PKGBUILD`.
