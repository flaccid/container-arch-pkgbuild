#!/bin/sh -e

if [ ! -z "$AUR_PACKAGES" ]; then
  aurman -S --noedit --noconfirm --pgp_fetch $AUR_PACKAGES
fi
