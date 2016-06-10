From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 10 Jun 2016 23:49:00 +0200
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160610214357.GA1650@katana>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana>
Message-ID: <20160610214900.GH11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 10, 2016 at 11:43:57PM +0200, Wolfram Sang wrote:
> > > Well, slightly better.
> > 
> > No, it should be much better.  You would have to look at the standard 
> 
> I use id-utils regularly and it is indeed at least a magnitude better.
> The indexing often pays off already with the first coccinelle run for
> me. Highly recommended.

AFAICT coccinelle does not have integration support for id-utils though.

  Luis
