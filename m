From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 20:00:00 +0200
Subject: [Cocci] [PATCH v3 3/6] scripts: add glimpse.sh for indexing the
 kernel
In-Reply-To: <trinity-8eae95d7-f827-44c4-b4d3-123561a053f8-1465986379121@3capp-webde-bap31>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
 <1465935820-14010-4-git-send-email-mcgrof@kernel.org>
 <trinity-8eae95d7-f827-44c4-b4d3-123561a053f8-1465986379121@3capp-webde-bap31>
Message-ID: <20160615180000.GW11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 12:26:19PM +0200, SF Markus Elfring wrote:
> > Glimpse is a tool you can use to index the kernel.
> > The tool was recently open sourced under the ISC license
> > and can be obtained at:
> 
> Do you find any official announcement for this software evolution?

I had reached out to Udi Manber in 2014, with the help of a few others we
helped persuade University of Arizona of an ISC release.

http://webglimpse.net/

Its vaguely mentioned there. That's as good as it gets...

> Is the wording "recent" really appropriate if you would eventually like to refer to a repository which was published in the year 2014?
> https://github.com/gvelez17/glimpse/

Sadly the original release didn't compile, I reported the issue in hopes it would
be fixed. Nothing has happened since and I got tired of waiting so I forked
and fixed it myself. I sent a pull request but I don't think its been merged
yet.

  Luis
