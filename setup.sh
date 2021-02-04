P=$(pwd)
cd ../tezos
ln -s $P/exclude .git/info
ln -s $P/.vscode $(pwd)
ln -s $P/.envrc $(pwd)
cd $P
