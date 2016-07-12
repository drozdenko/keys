# Monterail team members public keys

File name should be the same as github username.

At the end of the key please put your Monterail email address.

## Usage:

```bash
curl keys.hussa.rs/sheerun
curl keys.hussa.rs/chytreg

# etc.
```

## Public key matcher:

This simple ruby script match known Monterail public keys against input `authorized_keys` file.

```
bin/known-key-matcher ~/.ssh/authorized_keys
```

It will produce `tmp/known_authorized_keys` and `tmp/unknown_authorized_keys`.
