From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 20 May 2013 19:34:06 +0200
Subject: [Cocci] isomorphism with unlikely
Message-ID: <20130520173406.GB5890@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

using 1.0-rc16 from debian, I use the following semantic patch:

@@
expression r, p, n;
@@
	r = platform_get_resource(p, IORESOURCE_MEM, n);
	...
(
-	if (!r) { ... }
|
-	if (unlikely(!r)) { ... }
|
-	if (unlikely(r == NULL)) { ... }
)

and running against the latest kernel tree (~3.10-rc1):

spatch --sp-file unlikely_iso.cocci ~/Kernel/linux/drivers/net/ethernet/renesas/sh_eth.c

gives me a match:

-	if (unlikely(res == NULL)) {
...

Note that I have two alternations with 'unlikely' because using '!r'
alone will not give me a match. I guess the isomorphism is skipped for
some reason when used as an argument of unlikely. If so, is it possible
to enforce it somehow? Or would it be even better to make 'unlikely' an
isomorphism itself, so that the semantic patch doesn't need to know
anything about 'unlikely'?

Thanks,

   Wolfram
