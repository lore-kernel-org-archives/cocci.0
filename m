From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 5 Oct 2017 21:57:00 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: api: detect duplicate chip data
	arrays
In-Reply-To: <1507233246.4434.44.camel@perches.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
 <alpine.DEB.2.20.1710052113090.2626@hadrien>
 <1507230959.4434.39.camel@perches.com>
 <alpine.DEB.2.20.1710052116480.2626@hadrien>
 <1507231856.4434.41.camel@perches.com>
 <alpine.DEB.2.20.1710052138150.2626@hadrien>
 <1507233246.4434.44.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1710052154310.2626@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 5 Oct 2017, Joe Perches wrote:

> On Thu, 2017-10-05 at 21:40 +0200, Julia Lawall wrote:
> > On Thu, 5 Oct 2017, Joe Perches wrote:
> > > btw: spatch 1.7 doesn't seem to have a tag in git
> > >
> > > From the script:
> > >
> > >     // Requires: 1.0.7
> > >
> > > Assuming this is correct, then this doesn't even run today
> > > except maybe on your system.
> >
> > It runs on the current github version.  If you don't have the github
> > version it will suffer from false negatives, but nothing will break.
>
> fyi: there's no tag for 1.0.7 there either.

Yes, I know.  1.0.7 doesn't exist.  I didn't think it would be meaningful
to put the actual version I get with 1.0.6 with the commit id, because
commit ids aren't ordered.  I hoped that 1.0.7 would be released, but I
haven't gotten confirmation that all of the makefile issues have been
resolved.

julia
