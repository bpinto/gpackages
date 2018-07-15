#!/usr/bin/env bash

set -o pipefail
set -o errexit
set -o nounset

error() {
  echo -e "\e[31m$1"
}

info() {
  echo -e "\e[0m$1"
}

success() {
  echo -e "\e[32m$1"
}

info 'Copying configuration...'
if test -e config/secrets.yml; then
  success '  File "config/secrets.yml" already exists.'
else
  cp -n config/secrets.yml.example config/secrets.yml
fi

info 'Installing gems...'
if bundle install --quiet; then
  success '  Installed.'
else
  error '  Installation failed.'
  exit 1
fi

info 'Updating gentoo packages tree...'
if git -C /mnt/packages-tree/gentoo pull --rebase &>/dev/null; then
  success '  Updated.'
else
  error '  Update failed.'
  exit 1
fi

info 'Updating md5...'
if bin/update-md5.sh; then
  success '  Updated.'
else
  error '  Update failed.'
  exit 1
fi

info 'Updating USE flags...'
if bin/update-use.sh; then
  success '  Updated.'
else
  error '  Update failed.'
  exit 1
fi

info 'Creating indexes...'
if rake kkuleomi:index:init; then
  success '  Created.'
else
  error '  Creation failed.'
  exit 1
fi

info 'Seeding packages...'
if rake kkuleomi:update:all; then
  success '  Seeded.'
else
  error '  Packages seed failed.'
  exit 1
fi
