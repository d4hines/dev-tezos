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
.direnv
" > ./.git/info/exclude

echo "Adding Nix..."
rm -rf ./nix
rm -rf ./shell.nix
ln -s $P/nix $(pwd)
ln -s $P/shell.nix $(pwd)

echo "Adding .vscode settings..."
rm -rf .vscode
ln -s $P/.vscode $(pwd)

echo "Adding dir-env config..."
rm -f .envrc
ln -s $P/.envrc $(pwd)

# echo "Adding aliases..."

# The .aliases folder is added to the path
# via the .envrc script 
# function make_alias () {
#     mkdir -p .aliases
#     p=".aliases/$1"
#     rm -f $p
#     echo "#!/usr/bin/env bash" >> $p
#     echo "$2" >> $p
#     chmod +x $p
# }

# make_alias "cdp" 'cd $TEZOS_DIR/src/proto_alpha/lib_protocol'
# make_alias "cdt" 'cd $TEZOS_DIR'
# make_alias "cdu" 'cd $TEZOS_DIR/src/proto_alpha/lib_protocol/test/unit'
# make_alias "turn_off_warnings" 'export OCAMLPARAM="_,w=-27-26-32-33-20-21"'
# make_alias "runtest" 'dune build --terminal-persistence=clear-on-rebuild  @runtest_proto_alpha --watch'
# make_alias "test_globals" '(cdu && dune build @runtest --force ) && dune exec ./src/proto_alpha/lib_protocol/test/main.exe -- test "global table of constants" -c && tezt global_constant'
# make_alias "dbw" 'dune build --terminal-persistence=clear-on-rebuild --watch'
# make_alias "create_mockup" '
# 	if [[ ! -d /tmp/mockup ]]; then
# 		tezos-client \
# 		  --protocol ProtoALphaALphaALphaALphaALphaALphaALphaALphaDdp3zK \
# 		  --base-dir /tmp/mockup \
# 		  --mode mockup \
# 		  create mockup
# 	fi
# '
# make_alias "destroy_mockup" 'rm -rf /tmp/mockup'
# make_alias "mockup_client" 'create_mockup && tezos-client --mode mockup --base-dir /tmp/mockup "$@"'
# make_alias "client" 'mockup_client "$@"'
# make_alias "w" 'watchexec -c -e ml,mli -w src "$@"'
# make_alias "tezt" '(cd $TEZOS_DIR && dune exec tezt/tests/main.exe -- "$@"'

echo "Done! Enjoy hacking on Tezos 🚀"
cd $P
