From: joe@perches.com (Joe Perches)
Date: Sun, 18 Mar 2018 11:25:53 -0700
Subject: [Cocci] coccinelle & linux-kernel: unindent blocks by reversing
	tests?
In-Reply-To: <alpine.DEB.2.20.1803181848370.2420@hadrien>
References: <1521391861.27411.27.camel@perches.com>
 <alpine.DEB.2.20.1803181848370.2420@hadrien>
Message-ID: <1521397553.27411.38.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2018-03-18 at 18:50 +0100, Julia Lawall wrote:
> 
> On Sun, 18 Mar 2018, Joe Perches wrote:
> 
> > There are many blocks of code that could be
> > unindented and so neatened by reversing tests.
[]
> > Which often saves many vertical lines by reducing
> > now unnecessary line-wrapping done at 80-columns.
> 
> I tried it.  One can't easily make the transformation when there is a
> variable declaration in the block.  And Coccinelle doesn't move leading
> comments over to the left.  Most of the examples I found seemed to have
> only one level of opportunity.  I don't know if the churn is worth it in
> that case.  On a more complex example, the pretty printer crashes, so I'll
> have to look into that.

[]

> > A trivial hand-produced example selected randomly:
[]
> > ---
> >  .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        | 455 +++++++++------------
> >  1 file changed, 201 insertions(+), 254 deletions(-)

Dunno about the churn, but converting many lines of badly
wrapped simple statements and reducing line count seems
somewhat worthwhile.
