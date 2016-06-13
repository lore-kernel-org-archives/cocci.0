From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 13 Jun 2016 20:37:59 +0200
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <alpine.DEB.2.02.1606110751560.2114@localhost6.localdomain6>
References: <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana>
 <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana>
 <20160610220831.GI11948@wotan.suse.de>
 <20160610222521.GJ11948@wotan.suse.de>
 <20160611054625.GA1824@katana>
 <alpine.DEB.2.02.1606110751560.2114@localhost6.localdomain6>
Message-ID: <20160613183759.GN11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 11, 2016 at 07:54:39AM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 11 Jun 2016, Wolfram Sang wrote:
> 
> > 
> > > real    16m11.692s
> > > user    127m50.388s
> > > sys     0m2.168s
> > 
> > That's better but not a magnitude, I wonder.
> 
> I think that it is because the filtering that Coccinelle does already 
> works pretty well, and there are quite a lot of files (7514) that contain 
> kfree.

Is there another scripts/coccinelle/ file I can use to test against to demo
against glimpse/idutils/gitgrep best?

  Luis
