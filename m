From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 3 Oct 2015 18:24:27 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: misc: remove "complex return code"
 warnings
In-Reply-To: <20151001174718.GJ4284@localhost>
References: <1443652647-23097-1-git-send-email-johan@kernel.org>
 <alpine.DEB.2.02.1510010716280.2233@localhost6.localdomain6>
 <20151001174718.GJ4284@localhost>
Message-ID: <alpine.DEB.2.10.1510031823480.2586@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Perhaps there is a more restricted version that can be acceptable, but I'm
OK with dropping the current version.

julia

On Thu, 1 Oct 2015, Johan Hovold wrote:

> On Thu, Oct 01, 2015 at 07:20:10AM +0200, Julia Lawall wrote:
> > On Wed, 30 Sep 2015, Johan Hovold wrote:
> >
> > > This effectively reverts 932058a5d5f9 ("coccinelle: misc: semantic patch
> > > to delete overly complex return code processing").
> > >
> > > There can be both symmetry and readability reasons for not wanting to do
> > > the final function call as part of the return statement and to maintain
> > > a clear separation of success and error paths.
> > >
> > > Since this is in no way mandated by the coding standard, let's just
> > > remove this semantic patch to avoid having "clean up" patches being
> > > posted over and over in response to these Coccinelle warnings.
> >
> > What do you mean by "posted"?  Are you referring to 0-day build testing
> > or individual usage of make coccicheck?  Maybe it would make sense to
> > remove the semantic patch from 0-day build testing but leave it in the
> > kernel, perhaps removing the < 0 case because that one in practice doesn't
> > seem to turn up much that is useful?
>
> Individuals running coccicheck on in-kernel code and posting patches to
> "fix warnings", where the end result is not necessarily an improvement.
>
> But I don't think these warnings should be enabled for 0-day build
> testing either as it is should be up to the author to decide what style
> to prefer in each case.
>
> > Perhaps it could also be improved to detect a previous != 0 case and then
> > not return a warning.  On some functions, this change can make some nice
> > simplifications.
>
> Yes, that would at least improve things.
>
> I don't think warnings should be generated at all for the following
> code:
>
> {
> 	int ret;
>
> 	ret = init_a(...);
> 	if (ret)
> 		return ret;
>
> 	ret = init_b(...);
> 	if (ret)
> 		return ret;
>
> 	return 0;
> }
>
> as it is (at least to me) preferred over:
>
> {
> 	int ret;
>
> 	ret = init_a(...);
> 	if (ret)
> 		return ret;
>
> 	return init_b(...);
> }
>
> for symmetry and readability reasons (e.g. I don't have to look at
> init_b to figure out what the functions returns). And with a long
> parameter list to init_b with line breaks, this would look even worse.
>
> But either way, it should be up to the author of the code to decide what
> style to use.
>
> Thanks,
> Johan
>
