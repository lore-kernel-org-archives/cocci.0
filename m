From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Oct 2014 14:32:01 +0200
Subject: [Cocci] can't match a simple line?
Message-ID: <20141009123201.GA1666@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

this is so simple yet I don't see what I do wrong?

$ spatch --version
spatch version 1.0.0-rc22 with Python support and with PCRE support

(from Debian but same with rc21):

The rule 'test.cocci':

@@
@@
- 	module_platform_driver(...);

The command line:

spatch -sp_file test.cocci drivers/i2c/muxes/

No removals?

init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: drivers/i2c/muxes/i2c-arb-gpio-challenge.c
(ONCE) Expected tokens module_platform_driver
Skipping:drivers/i2c/muxes/i2c-mux-pca954x.c
HANDLING: drivers/i2c/muxes/i2c-mux-pinctrl.c
HANDLING: drivers/i2c/muxes/i2c-mux-gpio.c
Skipping:drivers/i2c/muxes/built-in.mod.c
Skipping:drivers/i2c/muxes/i2c-mux-pca9541.c

It should match, or?

Confused,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141009/223d23de/attachment.asc>
