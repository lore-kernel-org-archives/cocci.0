From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 Apr 2014 17:27:20 +0200 (CEST)
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <534BF3B3.90007@users.sourceforge.net>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
 <534BF121.40607@users.sourceforge.net>
 <alpine.DEB.2.10.1404141634180.2591@hadrien>
 <534BF3B3.90007@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404141725420.2572@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 14 Apr 2014, SF Markus Elfring wrote:

> > There was some proble about really huge regular expressions, which I think
> > must be a library problem, not a Coccinelle problem, so I don't plan to do
> > anything about it.
>
> Did you eventually reproduce exceptions from the handling of a bit smaller
> alternation in a SmPL constraint once more?

Yes, I believe so.

> How are the chances that if this one would be fixed that the bigger filter
> pattern will also work?

No chance.  The problems are completely unrelated.  In OCaml it is not
possible to test equality of certain kinds of values.  PCRE regular
expressions are this kind of value.  Str regular expressions can be
compared, so this problem did not show up until we added PCRE support.

julia
