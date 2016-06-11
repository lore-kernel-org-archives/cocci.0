From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jun 2016 08:05:54 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160611055840.GB1824@katana>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana> <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana> <20160610220831.GI11948@wotan.suse.de>
 <alpine.DEB.2.02.1606110717540.2114@localhost6.localdomain6>
 <20160611055840.GB1824@katana>
Message-ID: <alpine.DEB.2.02.1606110800360.2114@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 11 Jun 2016, Wolfram Sang wrote:

> 
> > It's not as efficient as glimpse because the query language is simpler.  
> 
> Interesting, what is missing compared to glimpse?

Glimpse allows queries that are arbitrary formulas, up to a limited level 
of complexity, involving both && and ||.  For idutils, Coccinelle runs lid 
on each of the tokens in the formula, and then does unions and 
intersections on the result.

julia

> > So more filtering has to be done at the ocaml level.  But it's probably 
> > fine in most cases.
> 
> For me, it has two advantages over glimpse:
> 
> a) it is in the debian package repository
> b) the same database can be used with the code browser 'seascope'
>    which can do nice things by feeding ctags on the fly with data
>    from id-utils.
> 
> Mileages vary, of course, just wanted to mention it to give pointers.
> 
> 
