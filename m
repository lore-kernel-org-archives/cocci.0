From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 8 Jun 2013 21:02:17 +0200
Subject: [Cocci] Removing pointer declaration
In-Reply-To: <alpine.DEB.2.02.1306082052560.1968@localhost6.localdomain6>
References: <20130608172853.GA2997@katana>
 <alpine.DEB.2.02.1306082052560.1968@localhost6.localdomain6>
Message-ID: <20130608190217.GB2997@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Sat, Jun 08, 2013 at 08:53:19PM +0200, Julia Lawall wrote:
> On Sat, 8 Jun 2013, Wolfram Sang wrote:
> 
> > Hi,
> > 
> > This spatch:
> > 
> > @@
> > int *p;
> 
> This should be "identifier p".

I noticed meanwhile. Is it because the type cannot be checked because
the pointer has not been declared yet? And, in general, can I get some
more info about what went wrong besides "parse error" somehow? --debug
didn't help.

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130608/837973f5/attachment.asc>
