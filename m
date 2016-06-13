From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 13 Jun 2016 20:39:31 +0200
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <alpine.DEB.2.02.1606110723390.2114@localhost6.localdomain6>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana>
 <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana>
 <alpine.DEB.2.02.1606110723390.2114@localhost6.localdomain6>
Message-ID: <20160613183931.GO11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 11, 2016 at 07:24:51AM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 10 Jun 2016, Wolfram Sang wrote:
> 
> > > AFAICT coccinelle does not have integration support for id-utils though.
> > 
> > I used it just today ;) -- "--use-idutils ./ID"
> > 
> > ID was generated with simple 'mkid -s'.
> 
> Coccinelle includes a script scripts/idutils_index.sh
> 
> This does mkid -i C --output .id-utils.index *

I'll add support for detecting both. An issue of course is if any of these
indexes grows stale. So I'll advise against these and recommend gitgrep
unless the user has a hook to update index regularly.

  Luis
