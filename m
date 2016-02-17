From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 17 Feb 2016 16:07:39 +0100
Subject: [Cocci] keeping cast affects match?
In-Reply-To: <alpine.DEB.2.10.1602170949460.4547@hadrien>
References: <20160217144548.GA1769@katana>
 <alpine.DEB.2.10.1602170949460.4547@hadrien>
Message-ID: <20160217150737.GB1769@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The isomorphism that allows ignoring a cast only works when the type
> metavariable is used only once.  You uare using it twice.  The fact that
> you wanted to add it indicates that you really want it to be there.

Aha, I understand. Thank you for the explanation!

> I think that everything should be fine if you just move the (T) out of the
> removed and added code.

Much better! I still fall for thinking too much in terms of 'lines'
instead of 'tokens'. Prompt and proper response (again) much
appreciated. Thank you a ton!

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160217/9eb5ae14/attachment.asc>
