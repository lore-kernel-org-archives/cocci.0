From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jun 2016 07:54:39 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160611054625.GA1824@katana>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana> <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana> <20160610220831.GI11948@wotan.suse.de>
 <20160610222521.GJ11948@wotan.suse.de> <20160611054625.GA1824@katana>
Message-ID: <alpine.DEB.2.02.1606110751560.2114@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 11 Jun 2016, Wolfram Sang wrote:

> 
> > real    16m11.692s
> > user    127m50.388s
> > sys     0m2.168s
> 
> That's better but not a magnitude, I wonder.

I think that it is because the filtering that Coccinelle does already 
works pretty well, and there are quite a lot of files (7514) that contain 
kfree.

julia
