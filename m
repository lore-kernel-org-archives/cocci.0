From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 30 Mar 2016 14:19:34 +0200
Subject: [Cocci] [PATCH] scripts: coccinelle: remove check to move
 constants to right
In-Reply-To: <alpine.DEB.2.02.1603191840121.2259@localhost6.localdomain6>
References: <1458409079-4669-1-git-send-email-wsa@the-dreams.de>
 <alpine.DEB.2.02.1603191840121.2259@localhost6.localdomain6>
Message-ID: <20160330121934.GA9329@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Mar 19, 2016 at 06:43:08PM +0100, Julia Lawall wrote:
> On Sat, 19 Mar 2016, Wolfram Sang wrote:
> 
> > The header mentions this check depends on personal taste. I agree.
> > Running coccicheck on patches before I apply them, this SmPL produced
> > enough false positives for me that I'd rather see it removed.
> 
> An improvement is coming up, that should be more acceptable.  However, 
> it's being held up by the need for some bug fixes in Coccinelle.  A 
> release of Coccinelle is planned for the beginning of April.  Perhaps 
> it is just as well to just remove this version for now.
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Michal, can we have that in v4.6 please? The false positives are
annoying...

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160330/ace4c39e/attachment.asc>
