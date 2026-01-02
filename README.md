## Connect to SFTP Server

Here’s a safe one-liner for connecting non-interactively without the host key prompt:

```bash
sftp -i ./ssh/keys/sftp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -P 2222 user@localhost
```

**Explanation:**

* `-i ./ssh/keys/sftp` → Use your private key.
* `-o StrictHostKeyChecking=no` → Automatically accept unknown host keys.
* `-o UserKnownHostsFile=/dev/null` → Don’t save the host key anywhere.
* `-P 2222` → Connect to port 2222 (your mapped SFTP port).

## Verify private and public keys

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

If you want, I can also make a **version that works for multiple key pairs at once**, very handy if you generate several keys. Do you want me to do that?
