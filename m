From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Oct 2018 17:36:52 +0200 (CEST)
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <CAOZdJXXgW3SOgiVOKijaooPipwDNUqMm3ScZ0XUU2d3F4Yok8A@mail.gmail.com>
References: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
 <alpine.DEB.2.21.1810100741210.2477@hadrien>
 <CAOZdJXXgW3SOgiVOKijaooPipwDNUqMm3ScZ0XUU2d3F4Yok8A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1810101735550.3396@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Line 112 is:
>
> // Use Python to clean up the string literals.
> // Comments are still C-style though
> @depends on rules@
> @r@             <--- line 112
> constant char[] c;
> expression list[n] es;
> @@

You can't put multiple @@'s at the beginning of a rule.  This should be
just:

@r depends on rules@
...
@@

julia
