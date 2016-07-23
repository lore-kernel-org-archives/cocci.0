From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 23 Jul 2016 15:42:35 +0200 (CEST)
Subject: [Cocci] Better documentation around SmPL ellipsis usage?
In-Reply-To: <1a83b399-6be0-c5ff-fc96-bb9b9fd21094@users.sourceforge.net>
References: <1469178343-29192-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1607221855500.4131@hadrien>
 <20160722190839.GA15538@osadl.at>
 <alpine.DEB.2.10.1607231242420.3304@hadrien>
 <1a83b399-6be0-c5ff-fc96-bb9b9fd21094@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1607231542050.3490@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 23 Jul 2016, SF Markus Elfring wrote:

> > The <+... ...+> starts the matching process at the beginning of the
> > function and ends it at the end of the function, instead of just working
> > on each if one by one.  Thus <+... ...+> should be much less efficient.
> > Also with <+... ...+> if you put a position variable on eg the if, you
> > will get a single position array with all the matches, whereas without it
> > you get one position array per if.
>
> How are the chances that such kind of information will also find its way
> into the section "Dot variants" of the manual?
> https://github.com/coccinelle/coccinelle/blob/3b52bd3c6960dc996186e1c58c96355db288825c/docs/manual/cocci_syntax.tex#L632

About the same as the chance that someone will make a patch suitable for
adding the information.

julia
