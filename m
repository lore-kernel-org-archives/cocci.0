From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Jun 2016 21:48:30 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160613185521.GB2238@katana>
References: <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana> <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana> <20160610220831.GI11948@wotan.suse.de>
 <20160610222521.GJ11948@wotan.suse.de> <20160611054625.GA1824@katana>
 <alpine.DEB.2.02.1606110751560.2114@localhost6.localdomain6>
 <20160613183759.GN11948@wotan.suse.de> <20160613185521.GB2238@katana>
Message-ID: <alpine.DEB.2.02.1606132148130.2066@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 13 Jun 2016, Wolfram Sang wrote:

> 
> > Is there another scripts/coccinelle/ file I can use to test against to demo
> > against glimpse/idutils/gitgrep best?
> 
> I'd think this one may be a candidate:
> 
> scripts/coccinelle/misc/irqf_oneshot.cocci
> 
> Not too many, but quite some matches over the tree.

Seems like a reasonable choice.

julia
