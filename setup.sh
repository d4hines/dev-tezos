#!/usr/bin/env bash

set -e

P=$(pwd)

cd ${1:-"../tezos"}

echo "Adding hooks to local Git db..."
rm -f .git/hooks/pre-commit
ln -s $P/hooks/pre-commit .git/hooks/pre-commit

echo "Changing local Git excludes..."
echo "\
.vscode
.envrc
.ocamlinit
nix
shell.nix
flake.nix
.direnv
Makefile
" > ./.git/info/exclude

echo "Adding Nix..."
rm -rf ./nix
ln -s $P/nix $(pwd)

rm -rf ./shell.nix
ln -s $P/shell.nix $(pwd)

rm -rf ./flake.nix
ln -s $P/flake.nix $(pwd)

echo "Adding .vscode settings..."
rm -rf .vscode
ln -s $P/.vscode $(pwd)

echo "Adding dir-env config..."
rm -f .envrc
ln -s $P/.envrc $(pwd)

echo "Patching Makefile..."
git apply $P/make_patch.diff 2> /dev/null
git update-index --skip-worktree Makefile

echo "Done! Enjoy hacking on Tezos 🚀"
cd $P
