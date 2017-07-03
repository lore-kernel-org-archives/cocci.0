From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 3 Jul 2017 19:14:27 +0200
Subject: [Cocci] [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
In-Reply-To: <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
 <20170703133602.ejcdu35ku3i63cj2@earth>
 <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
Message-ID: <20170703171427.qtpodt7watymphac@earth>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Mon, Jul 03, 2017 at 07:37:59PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 3, 2017 at 4:36 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:
> 
> >  * drivers/gpio/gpio-pca953x.c (line 190-192)
> 
> It has double conversion there:
> 1. LE CPU: Read as LE and converted to LE (no-op), so, just u16
> 2. BE CPU: Read as BE and converted to LE, makes it __le16
> 
> Looks like the conversion is not needed, only get_unaligned() is necessary.
>
> P.S. What about lines 244-245 there? I think they are no-op.
> Interesting that those two parts were added in quite different
> commits.

val[0] = (u16)ret & 0xFF;
val[1] = (u16)ret >> 8;

looks like cpu_to_be16()?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170703/d871e936/attachment-0001.asc>
