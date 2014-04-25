From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 25 Apr 2014 18:34:14 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
Message-ID: <20140425163414.GA12354@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> So I wanted to ask people familiar with cocinelle whether is feasible
> or not to model my change as a semantic patch so I can start reading
> cocinelle papers and looking at examples or if is too complex for
> cocinelle then I'll continue grepping and manually change as I've been
> doing so far.

I would do it with Coccinelle. First learning curve may be steep, but
once mastered, a very flexible tool, if adjustments are needed (e.g.
because proposed API changes).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140425/dffd5fae/attachment.asc>
