#!/bin/sh

BASE_DIR="./ssh"
PUB_DIR="$BASE_DIR/keys"
KEY_NAME="sftp"

PRIVATE_KEY="$BASE_DIR/$KEY_NAME"
PUBLIC_KEY="$PUB_DIR/$KEY_NAME.pub"

echo "Creating SSH directories if they don't exist"
mkdir -p "$PUB_DIR"

echo "Cleaning up existing SSH keys"
rm -f "$PRIVATE_KEY" "$PUBLIC_KEY"

echo "Generating new SSH key pair"
ssh-keygen -t rsa -b 4096 -f "$PRIVATE_KEY" -N ""

echo "Moving public key to public-only directory"
mv "$PRIVATE_KEY.pub" "$PUBLIC_KEY"

echo "Setting secure permissions"
chmod 600 "$PRIVATE_KEY"
chmod 644 "$PUBLIC_KEY"

echo "Keys generated:"
echo "Private key:"
ls -l "$PRIVATE_KEY"
echo "Public key:"
ls -l "$PUBLIC_KEY"
