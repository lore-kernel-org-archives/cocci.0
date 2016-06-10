From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Sat, 11 Jun 2016 00:25:21 +0200
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160610220831.GI11948@wotan.suse.de>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana>
 <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana>
 <20160610220831.GI11948@wotan.suse.de>
Message-ID: <20160610222521.GJ11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 11, 2016 at 12:08:32AM +0200, Luis R. Rodriguez wrote:
> On Fri, Jun 10, 2016 at 11:51:26PM +0200, Wolfram Sang wrote:
> > > AFAICT coccinelle does not have integration support for id-utils though.
> > 
> > I used it just today ;) -- "--use-idutils ./ID"
> > 
> > ID was generated with simple 'mkid -s'.
> > 
> 
> Sweet, testing that now.

Boooyah :D

real    16m11.692s
user    127m50.388s
sys     0m2.168s

  Luis
