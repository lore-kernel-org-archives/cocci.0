From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 17 Feb 2016 16:19:57 +0100
Subject: [Cocci] keeping cast affects match?
In-Reply-To: <alpine.DEB.2.10.1602171010540.4547@hadrien>
References: <20160217144548.GA1769@katana>
 <alpine.DEB.2.10.1602170949460.4547@hadrien>
 <20160217150737.GB1769@katana>
 <alpine.DEB.2.10.1602171010540.4547@hadrien>
Message-ID: <20160217151952.GC1769@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> like this, it can be better to just pull the common part out into the
> context.

That was definately the case here. After doing that for the other three
rules I had, two of them became identical :) Also, I got more matches,
because there was context I had not anticipated yet. Big win!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160217/d74e0b87/attachment.asc>
