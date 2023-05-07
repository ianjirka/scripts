# Introduction

This repo contains scripts useful in bootstrapping Ubuntu environments.

## Getting started

To get started, run the Ubuntu setup script from this repo.

### Option 1 : Run script from GitHub

```bash
curl -L https://raw.githubusercontent.com/ianjirka/scripts/main/setup_ubuntu.sh | bash
```

### Option 2 : Sync repo locally and run

```bash
# Install Github CLI
# Instructions from [GitHub](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

cd ~
gh login auth
git clone https://github.com/ianjirka/scripts.git scripts
scripts/setup_ubuntu.sh
```