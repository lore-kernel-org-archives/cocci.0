From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 Jun 2016 07:56:29 +0200 (CEST)
Subject: [Cocci] [PATCH v3 7/8] coccicheck: refer to coccicheck bottest
 wiki for documentation
In-Reply-To: <20160622000730.GL25646@wotan.suse.de>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-8-git-send-email-mcgrof@kernel.org>
 <9db10e04-779a-1bae-0ffe-2d43e5f46d2e@imag.fr>
 <alpine.DEB.2.02.1606212318280.2040@localhost6.localdomain6>
 <20160622000730.GL25646@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606220754120.2082@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 22 Jun 2016, Luis R. Rodriguez wrote:

> On Tue, Jun 21, 2016 at 11:18:41PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Tue, 21 Jun 2016, Nicolas Palix (LIG) wrote:
> > 
> > > Hi,
> > > 
> > > Le 21/06/16 ? 21:21, Luis R. Rodriguez a ?crit :
> > > > Sprinkling *tons* of documentation on the script is not a good
> > > > idea, instead refer to a wiki for further coccicheck documentation:
> > > > 
> > > > https://bottest.wiki.kernel.org/coccicheck
> > > > 
> > > > This page shall always refer to the linux-next iteration of
> > > > scripts/coccicheck.
> > > 
> > > Can you say a word about Documentation/coccinelle.txt too ?
> > > And update it according to the script changes.
> > 
> > I think this would be a good idea.
> 
> I'd much prefer to just keep docs in a wiki, and we nuke this outdated doc or
> refer in the Documentation/coccinelle.txt to the wiki. This lets us document
> things much faster and lets us add more information in a much nicer format. But
> that's just me...

External links have a surprising way of disappearing.  They also require 
internet access.

julia

> The existing file Documentation/coccinelle.txt even provides documentation on
> how to build coccinelle --we're way passed that point. Note, I havne't
> updated the docs on the wiki to refer to any of this, and would not unless
> these changes get merged at least to linux-next.
> 
>   Luis
> 
