#!/bin/sh

# slow but use the same build as used on Github Actions
exec docker run --rm --volume $PWD:/src -p "1313:1313" philipf/hugo-builder hugo serve --bind=0.0.0.0 --baseUrl=blog.local --verbose --buildDrafts --buildFuture

# Requires local installation of Hugo and dependencies
#exec env PATH=$PWD/bin:$PATH hugo serve --verbose --baseUrl=blog.local --bind=0.0.0.0 --buildDrafts --buildFuture
