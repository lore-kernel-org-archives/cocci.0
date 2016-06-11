From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jun 2016 07:24:51 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <20160610215126.GB1650@katana>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
 <20160610211820.GG11948@wotan.suse.de>
 <alpine.DEB.2.02.1606102319480.2070@localhost6.localdomain6>
 <20160610214357.GA1650@katana> <20160610214900.GH11948@wotan.suse.de>
 <20160610215126.GB1650@katana>
Message-ID: <alpine.DEB.2.02.1606110723390.2114@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 10 Jun 2016, Wolfram Sang wrote:

> > AFAICT coccinelle does not have integration support for id-utils though.
> 
> I used it just today ;) -- "--use-idutils ./ID"
> 
> ID was generated with simple 'mkid -s'.

Coccinelle includes a script scripts/idutils_index.sh

This does mkid -i C --output .id-utils.index *

julia
