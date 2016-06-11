From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jun 2016 07:55:18 +0200 (CEST)
Subject: [Cocci] [PATCH 2/4] coccicheck: enable paramap support
In-Reply-To: <5ec86b43-5fc8-b4b7-11a3-f1cef751270d@users.sourceforge.net>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-3-git-send-email-mcgrof@kernel.org>
 <5ec86b43-5fc8-b4b7-11a3-f1cef751270d@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1606110754520.2114@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 11 Jun 2016, SF Markus Elfring wrote:

> > Also enable the load balancing to be dynamic, so that
> > if a thread finishes early we keep feeding it.
> 
> Is this functionality influenced by the parameter "chunksize"?

Yes, without chunksize the distribution of work to processes is static.

julia
