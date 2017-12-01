From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 1 Dec 2017 10:18:02 +0100 (CET)
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <1512116859.25588.4.camel@sipsolutions.net>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 (sfid-20171201_064358_586047_BC8ED658)
 <1512116859.25588.4.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1712011015160.2865@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 1 Dec 2017, Johannes Berg wrote:

> +cocci list
>
> Hi,
>
> Looks like you made a really deep investigation here - awesome, thanks
> for doing that!

Hello,

The attribute metavariable declaration has become attribute name, to be
more like eg declarer name, iterator name, etc.

The handling of attributes has also been extended so that you can actually
match against them in some cases, such as on function declarations.  On
the oher hand, nothing was done to allow attributes in front of types that
are alone.

I can try to fix this.  In the short term, perhaps using 1.0.4 is
acceptable.

julia

>
>
> On Thu, 2017-11-30 at 21:43 -0800, Remington Furman wrote:
> >
> > Full log using genl-const.cocci
> > init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> > meta: parse error:
> >    File "./patches/0027-genl-const/genl-const.cocci", line 2, column 10,
> > charpos = 13
> >    around = '__genl_const',
> >    whole content = attribute __genl_const;
> > [...snip callstack...]
>
> FWIW, the patch is pretty simple:
>
> @@
> attribute __genl_const;
> @@
> (
> -const struct genl_multicast_group
> +__genl_const struct genl_multicast_group
> |
> -const struct genl_ops
> +__genl_const struct genl_ops
> )
>
> (yes, that's the full patch)
>
>
> > This is very similar to this problem:
> > <https://www.spinics.net/lists/backports/msg04216.html>
> > The conclusion of that thread is that the --integrate workflow is
> > no longer supported.
> >
> > However, I am not using --integrate, and I am still getting
> > errors about parsing '__genl_const'.
>
> Yeah this --integrate is unrelated to the problem - the problem is that
> spatch can't parse this patch (any more).
>
> > Is that a bug in the patch
> > or possibly a regression in spatch?
>
> I think it's a regression in spatch.
>
> > I've tried v4.14-rc2 also,
> > but nothing older.
>
> That's a kernel version so not really relevant - spatch doesn't even
> attempt to apply the changes since it can't parse them.
>
> > This page has a lot of great example info, and suggested that it
> > could be a problem with my version of spatch. Specifically, that
> > I was missing the menhir and libmenhir-ocaml-dev packages when
> > building Coccinelle and a rebuild should help.
> > <http://stonyslp.blogspot.com/2017/08/backport-driver.html>
>
> That I don't know - I've never built spatch myself.
>
> > Unfortunately, I still have the same errors after running make
> > distclean and rebuilding.
> >
> > I have:
> > coccinelle $ git describe --tags
> > 1.0.6-365-gd73c6e6
> > coccinelle $ spatch --version
> > spatch version 1.0.6-00365-gd73c6e6 compiled with OCaml version 4.01.0
> > Flags passed to the configure script: [none]
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expresssions: PCRE
>
> That seems reasonable as far as configuration is concerned.
>
> > I found this patch which describes how older versions can't
> > handle the __genl_const changes (20150209):
> > <https://www.spinics.net/lists/backports/msg03223.html>
> >
> > But, I also see commit 748116c8 from shortly after (20150507)
> > which introduced genl-const.cocci and says only spatch 1.0.0-rc23
> > is needed.
>
> Right.
>
> > I feel like I'm close to figuring this out, but would appreciate
> > any help or pointers.
>
> Yeah I think you're pretty close.
>
> Can you try obtaining/building spatch 1.0.4? That definitely works for
> me, so I think there's probably a regression in spatch somewhere
> between 1.0.4 and the version that you're running.
>
> johannes
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
