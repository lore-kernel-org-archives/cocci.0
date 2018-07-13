From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Jul 2018 05:44:06 -0400 (EDT)
Subject: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <20180713091412.GA11250@himanshu-Vostro-3559>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559> <20180713080023.GB9638@nautica>
 <20180713091412.GA11250@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1807130540270.3044@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 13 Jul 2018, Himanshu Jha wrote:

> On Fri, Jul 13, 2018 at 10:00:23AM +0200, Dominique Martinet wrote:
> > Himanshu Jha wrote on Fri, Jul 13, 2018:
> > > > I expect each maintainer will pick their share of the patchs if they
> > > > agree with it and the rest will just be dropped?
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> takes coccinelle patches,
> > > so please cc him or your patch would be lost.
> >
> > Thanks, will do.
> >
> > > > +virtual patch
> > > > +virtual context
> > >
> > > You might consider adding context rule or remove this line perhaps ?
> >
> > Victim of copypasta, I'll remove this.
> >
> > > > +-strncpy at p(
> > > > ++strlcpy(
> > > > +  dest, src, sz);
> > > > +-dest[sz - 1] = '\0';
> > >
> > > The above rule produces an output that I think is not correct:
> > > --------------------------------------------------------------
> > > diff =
> > > diff -u -p a//ti/wl1251/acx.c b//ti/wl1251/acx.c
> > > --- a//ti/wl1251/acx.c
> > > +++ b//ti/wl1251/acx.c
> > > @@ -150,14 +150,7 @@ int wl1251_acx_fw_version(struct wl1251
> > >  	}
> > >
> > >  	/* be careful with the buffer sizes */
> > > -	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> > > -
> > > -	/*
> > > -	 * if the firmware version string is exactly
> > > -	 * sizeof(rev->fw_version) long or fw_len is less than
> > > -	 * sizeof(rev->fw_version) it won't be null terminated
> > > -	 */
> > > -	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
> > > +	strlcpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> > >
> > > -----------------------------------------------------------------
> > >
> > > I think the comment is useful and should not be removed.
> >
> > I agree this comment is useful now that I'm taking a closer look, I
> > glanced at this too fast.
> > I'm not sure how to make coccinelle not remove comments between lines
> > though?
>
> Well, there is no such facility in Coccinelle to ignore comments.
> You can hack with other facilities provided in SmPL though ;)
>
> Try this:
>
> $ spatch -D patch --sp-file strlcopy.cocci --very-quiet drivers/net/wireless/ti/wl1251/acx.c
>
> ---------------------------------------------------------------------
> virtual patch
>
> @depends on patch@
> expression dest, src, sz;
> identifier f;
> @@
>
> (
> - strncpy(
> + strlcpy(
>   dest, src, sizeof(sz));
> - dest[sizeof(sz) - 1] = '\0';
> |
> - strncpy(
> + strlcpy(
>   dest, src, f);
> - dest[f - 1] = '\0';
> )
> ---------------------------------------------------------------------
>
> This eliminates that case because expression is generic metavariable and
> it somehow matched whole "min(len, sizeof(...)..", so it better to
> divide the rules as done above to be more specific about the matching
> pattern.
>
> I thought to replace "identifier f" with "constant F" but that misses
> few cases.
>
> Also, it is advised to put a space affer '+/-'

Thanks Himanshu for the suggestions.

However, I'm not sure to follow the discussion.  The original problem was
that Coccinelle was removing a comment that should be preserved.  I think
that this occurs because the line just below the comment is completely
removed.  Coccinelle considers that the comment belongs with that line and
if the line is removed the comment won't make much sense.

In Himanshu's solution, the code is just not transformed at all, so as a
side effect the comment stays too.  Is that what is wanted in this case?

julia
