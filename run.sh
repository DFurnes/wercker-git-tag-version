#!/bin/sh

echo $PACKAGE_VERSION
git add .
git commit -m "Build assets for v$PACKAGE_VERSION."

echo "Listing tags on remote..."
git ls-remote --tags $GIT_REMOTE

echo "Listing matching tags on remote..."
git ls-remote --tags $GIT_REMOTE | grep "v$PACKAGE_VERSION"

echo "Attempting to create tag..."

if ( git ls-remote --tags $GIT_REMOTE | grep "v$PACKAGE_VERSION" );
then
  error 'Tag exists, skipping release.'
else
  echo "Good to go!"
  git tag -a v$PACKAGE_VERSION -m "Tagged release v$PACKAGE_VERSION."
  git push --tags $GIT_REMOTE
fi

