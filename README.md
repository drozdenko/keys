# Monterail team members public keys

File name should be the same as github username and placed in `files/active/[USERNAME].pub` location.

At the end of the key please put your Monterail email address.

All staled keys **shouldn't be removed** but placed in `files/trash` location!

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

## Ansible role

Installation:

```yml
# requirements.yml
---
- src: git+git@github.com:monterail/keys.git
  name: monterail.keys
```
```bash
$ ansible-galaxy install -r requirements.yml -p roles/
```

And edit `roles/monterail.keys/vars/main.yml` which should contain list of machine users and keys to be applied to it, e.g.:

```yml
# vars/main.yml
---
user: appuser
keys:
  - developer
  - sysadmin
  - other
```

Or in the playbook:

```yml
# playbooks/playbook.yml
- name: Setup

  roles:
    - { role: monterail.keys, user: "appuser", keys: ["developer", "sysadmin"] }
    - { role: monterail.keys, user: "otheruser", keys: ["developer", "sysadmin", "other"] }
