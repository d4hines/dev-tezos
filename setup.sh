P=$(pwd)
cd ../tezos
rm .git/info/exclude
rm .git/info/hooks/pre-push

ln -s $P/hooks/pre-push .git/hooks/pre-push
ln -s $P/exclude .git/info
ln -s $P/.vscode $(pwd)
ln -s $P/.envrc $(pwd)
cd $P
