## 1. Connect to SFTP Server

Here’s a safe one-liner for connecting non-interactively without the host key prompt:

```bash
sftp -i ./ssh/keys/sftp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -P 2222 user@localhost
```

**Explanation:**

* `-i ./ssh/keys/sftp` → Use your private key.
* `-o StrictHostKeyChecking=no` → Automatically accept unknown host keys.
* `-o UserKnownHostsFile=/dev/null` → Don’t save the host key anywhere.
* `-P 2222` → Connect to port 2222 (your mapped SFTP port).

## 2. Verify private and public keys

Here’s a compact **one-liner** for scripts that prints only `OK` if the keys match, or `MISMATCH` if they don’t:

```sh
[ "$(ssh-keygen -y -f ./ssh/sftp)" = "$(cat ./ssh/keys/sftp.pub)" ] && echo "OK" || echo "MISMATCH"
```

### ✅ How it works:

* `ssh-keygen -y -f ./ssh/sftp` → outputs the public key from the private key.
* `cat ./ssh/keys/sftp.pub` → reads the existing public key.
* `[ ... = ... ]` → checks if they are identical.
* `&& echo "OK"` → prints if they match.
* `|| echo "MISMATCH"` → prints if they don’t.

---

## 3. Run custom script

Use /etc/sftp.d/ for custom scripts and it will automatically run when the container starts. 

1. Create a script on your host:

```bash
# ./scripts/create_camt.sh
#!/bin/sh
mkdir -p /home/user/CAMT/CAMT054 /home/user/CAMT/CAMT053 /home/user/CAMT/CAMT052
chown -R 1007:1007 /home/user/CAMT
```

2. Mount it into the container:

```yaml
volumes:
  - ./scripts/create_camt.sh:/etc/sftp.d/01-create-camt.sh:ro
```

3. Ensure it’s executable:

```bash
chmod +x ./scripts/create_camt.sh
```

Now the container will **always run the script at startup**, creating your CAMT directories, even if you mount `./uploads` to `/home/user`.

---
