From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 3 Jul 2017 19:37:59 +0300
Subject: [Cocci] [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
In-Reply-To: <20170703133602.ejcdu35ku3i63cj2@earth>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
 <20170703133602.ejcdu35ku3i63cj2@earth>
Message-ID: <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 3, 2017 at 4:36 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:

>  * drivers/gpio/gpio-pca953x.c (line 190-192)

It has double conversion there:
1. LE CPU: Read as LE and converted to LE (no-op), so, just u16
2. BE CPU: Read as BE and converted to LE, makes it __le16

Looks like the conversion is not needed, only get_unaligned() is necessary.

P.S. What about lines 244-245 there? I think they are no-op.
Interesting that those two parts were added in quite different
commits.

-- 
With Best Regards,
Andy Shevchenko
