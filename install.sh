echo 'Adding new key to apt keyring...'
wget -qO - https://mfc-repos.github.io/key.asc | sudo apt-key add -
echo 'Installing https transport...'
sudo apt install -y apt-transport-https
echo 'Installing repo to list...'
echo 'deb https://mfc-repos.github.io mfc contrib' | sudo tee /etc/apt/sources.list.d/mfcoin.list
echo 'Updating apt database...'
sudo apt update
echo 'Installing MFCoin Core app...'
sudo apt install -y mfcoin
echo 'All done!'
