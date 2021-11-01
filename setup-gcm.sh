#/bin/bash
sudo sed -i -E 's/helper =.*//' /etc/gitconfig
git config --global credential.credentialStore gpg
git-credential-manager-core configure

if pass ls > /dev/null 2>&1; then
     exit 0
fi

# Init "pass"
cat > /tmp/gpginput <<EOF
     %echo Generating OpenPGP key for pass
     Key-Type: default
     Subkey-Type: default
     Name-Real: GitHub User ${GITHUB_USER}
     Name-Comment: Used to store git creds 
     Name-Email: noreply@github.com
     Expire-Date: 0
     %commit
     %echo done
EOF
gpg_output="$(gpg --batch --pinentry-mode loopback --generate-key --passphrase '' /tmp/gpginput 2>&1)"
key_id="$(echo "${gpg_output}" | grep -oP 'key\s+\K[^\s]+')"
pass init ${key_id}

rm -f /tmp/gpginput
