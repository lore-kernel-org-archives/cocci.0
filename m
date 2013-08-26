From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 26 Aug 2013 21:26:08 +0200
Subject: [Cocci] if statements including assignments
Message-ID: <20130826192608.GA3117@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'd basically need something like:

	if (... when != var)

to match. I couldn't find a way to express it. This is needed since
there are constructs like:

	if (var = something())

which I don't want to match since they assign var a value which is fine
in my case.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130826/d6e5c95f/attachment.asc>
