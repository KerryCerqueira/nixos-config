# Notes on Deployment
## Key Generation

Each host needs an age private key to decrypt its system secrets. Generate one
with

```sh
nix-shell -p age --run "age-keygen -o <hostname>.age"
```

I'm running with the convention of placing these system level keys in
`/etc/age/` and hardcoding the path into the system config as the sops default
decryption key. Different paths can be specified by setting the environment
variable `SOPS_AGE_KEY_FILE`. The super user must place the keyfile in
`/etc/age`, and be sure to set the correct permissions on the keyfile with

```sh
sudo chmod 0600 /etc/age/<hostname>.age
```

Generate a key for user secrets in the same way. The user key unlike the system
key is deployed by sops itself during the boot process by encrypting it in the
system `secrets.yaml` and deploying it to `/home/<user>/.config/sops/age`. Make
sure to make the user the owner of the keyfile for home-manager to pick it up.

If the user needs a declarative login password, its hash can be deployed by
sops. To get the hash save the password into a file (say `pwd.txt`) and run

```sh
cat pwd.txt | mkpasswd -s
```

If the user needs a declarative syncthing ID, you can generate a keypair with

```sh
syncthing -generate=myconfig
```

You can then find the keypair in `./myconfig/key.pem` etc.

## Non-declarative setup

- Set gnome keyboard shortcuts, interface settings, and add google and
microsoft accounts
- Set keepassxc interface settings and initialize ssh-agent
- Log into firefox sync, log browser into github, gmail, and outlook
- Set background image and profile image
- Log into steam
- Add empty `extra.lua` to `~/.config/nvim/lua/extra/`
