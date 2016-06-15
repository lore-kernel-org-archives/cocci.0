From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 17:45:07 +0200
Subject: [Cocci] [PATCH 4/4] scripts/coccinelle: require coccinelle >=
 1.0.4 on device_node_continue.cocci
In-Reply-To: <alpine.DEB.2.02.1606150807440.2231@localhost6.localdomain6>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606150807440.2231@localhost6.localdomain6>
Message-ID: <20160615154507.GM11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 08:08:41AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 14 Jun 2016, Luis R. Rodriguez wrote:
> 
> > Make use of the new kernel python requirements library to be able to
> > specify coccinelle binary version requirements. The cocci file
> > device_node_continue.cocci requires at least coccinelle 1.0.4.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  scripts/coccinelle/iterators/device_node_continue.cocci | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
> > index 38ab744a4037..b590de9418d1 100644
> > --- a/scripts/coccinelle/iterators/device_node_continue.cocci
> > +++ b/scripts/coccinelle/iterators/device_node_continue.cocci
> > @@ -12,6 +12,19 @@ virtual context
> >  virtual org
> >  virtual report
> >  
> > +// This uses a conjunction, which requires at least coccinelle >= 1.0.4
> > + at script:python@
> > +@@
> > +
> > +import sys
> > +from lib import reqs
> > +
> > +req = reqs.Req()
> > +req.coccinelle('1.0.4')
> > +if not req.reqs_match():
> > +    cocci.exit()
> > +    sys.exit(1)
> 
> This doesn't look very appealing to me.  Shouldn't Coccinelle handle this 
> itself?

Oh I agree, however what options do we have at the moment instead of an odd
parse error complaint ? This lets one annotate version requirements and is
backward compatible.

  Luis
