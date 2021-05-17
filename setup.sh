set -e

P=$(pwd)
cd ../tezos

echo "Adding hooks to local Git db..."
rm -f .git/hooks/pre-commit
ln -s $P/hooks/pre-commit .git/hooks/pre-commit

echo "Changing local Git excludes..."
rm -f .git/info/exclude
ln -s $P/exclude .git/info

echo "Adding .vscode settings..."
rm -rf .vscode
ln -s $P/.vscode $(pwd)

echo "Adding dir-env config..."
rm -f .envrc
ln -s $P/.envrc $(pwd)

echo "Done! Enjoy hacking on Tezos 🚀"
cd $P
