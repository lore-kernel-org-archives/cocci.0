From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Jun 2016 07:08:27 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160613212249.GR11948@wotan.suse.de>
References: <20160610214357.GA1650@katana>
 <20160610214900.GH11948@wotan.suse.de> <20160610215126.GB1650@katana>
 <20160610220831.GI11948@wotan.suse.de> <20160610222521.GJ11948@wotan.suse.de>
 <20160611054625.GA1824@katana>
 <alpine.DEB.2.02.1606110751560.2114@localhost6.localdomain6>
 <20160613183759.GN11948@wotan.suse.de> <20160613185521.GB2238@katana>
 <alpine.DEB.2.02.1606132148130.2066@localhost6.localdomain6>
 <20160613212249.GR11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606140706410.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 13 Jun 2016, Luis R. Rodriguez wrote:

> On Mon, Jun 13, 2016 at 09:48:30PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Mon, 13 Jun 2016, Wolfram Sang wrote:
> > 
> > > 
> > > > Is there another scripts/coccinelle/ file I can use to test against to demo
> > > > against glimpse/idutils/gitgrep best?
> > > 
> > > I'd think this one may be a candidate:
> > > 
> > > scripts/coccinelle/misc/irqf_oneshot.cocci
> > > 
> > > Not too many, but quite some matches over the tree.
> > 
> > Seems like a reasonable choice.
> 
> With this one on a 32-core system, I get:
> 
> glimpse:
> real    0m6.549s
> user    0m49.136s
> sys     0m3.076s
> 
> idutils:
> real    0m6.749s
> user    0m51.936s
> sys     0m3.876s
> 
> gitgrep:
> real    0m6.805s
> user    0m51.572s
> sys     0m4.432s
> 
> coccigrep:
> real    0m16.369s
> user    0m58.712s
> sys     0m5.064s
> 
> I redirected stderr to stdout, and verified glimpse output has:
> 
> glimpse request = request_threaded_irq
> 
> Does this match expectations?

Yes.  I'm not sure that gitgrep would work as well when there are multiple 
keywords.  It may descend to coccigrep.

julia
