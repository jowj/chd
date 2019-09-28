# serverbuild
this is a mess of a directory right now. sorry about that.

## ipsec.conf
```
config setup
    charondebug="ike 1, knl 1, cfg 0"
    uniqueids=no
```
This tells sswan to log daemon statuses for debugging and allow duplicate connections

```
conn ikev2-vpn
    auto=add
    compress=no
    type=tunnel
    keyexchange=ikev2
    fragmentation=yes
    forceencaps=yes
```
This starts the VPN config stanza. Use IKEv2 VPN tunnels and load this config everytime we start up.

```
    dpdaction=clear
    dpddelay=300s
    rekey=no
```
This clears any weird connections (i.e. if a client gets unexpectedly dced)

```
    left=%any
    leftid=@vpn.awful.club
    leftcert=awful-server-cert.pem
    leftsendcert=always
    leftsubnet=0.0.0.0/0
```
in strongswan grammer, "left" refers to serverside, apparently. this section is pretty selfexplanatory. The exception to that is `%any` i've got no fucking clue what that is.

```
    right=%any
    rightid=%any
    rightauth=eap-mschapv2
    rightsourceip=10.10.10.0/24
    rightdns=1.1.1.1,1.0.0.1
    rightsendcert=never
```
"right" side is client side.

```
    eap_identity=%identity
```
this tells sswan to always ask for un/pw on connect (eap.)
((also eeeep))


## ipsec.secrets
this file contains: secrets, for the love of god change the values.

`: RSA "server-key.pem"` declares wheere the private key lives and what algo was used
`your_username : EAP "your_password"` is very obvious.
