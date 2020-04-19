#!/usr/bin/env bash

# Pushing the homebrew metaphor to the breaking point — check for missing Brewfile dependencies, out of date formulas,
# and out of date casks. This script is just about making checks and showing the results, not installing or upgrading
# everything.
# TODO: maybe add a "fix" option?
# TODO: also rewrite with Thor for easier arg handling

# we know homebrew is likely to update itself the first time we call it, so let's get that out of the way
echo "Updating homebrew..."
brew update
echo "...done!"

# see if we've got everything installed we expect to
echo "Checking Brewfile dependencies..."
brew bundle check --verbose
echo "...done!"
echo "Fix with brew bundle [install]."

# what formulas are outdated? (brew bundle will take care of everything in the Brewfile but we may have other things
# installed)
echo "Checking formulae..."
brew upgrade --dry-run
echo "...done!"
echo "Fix with brew upgrade [formula]."

# what casks are outdated? and rejigger the format so we have one package per line like the formula output
echo "Checking casks..."
brew cask upgrade --dry-run | perl -pe "s/(.+? -> .+?), /\1\n/g"
echo "...done!"
echo "Fix with brew cask upgrade [formula]."
