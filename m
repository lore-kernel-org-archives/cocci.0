From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 20:43:06 +0200
Subject: [Cocci] scripts: add glimpse.sh for indexing the kernel
In-Reply-To: <70c633b7-4fb4-ca75-9589-612af6a2976c@users.sourceforge.net>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
 <1465935820-14010-4-git-send-email-mcgrof@kernel.org>
 <trinity-8eae95d7-f827-44c4-b4d3-123561a053f8-1465986379121@3capp-webde-bap31>
 <20160615180000.GW11948@wotan.suse.de>
 <70c633b7-4fb4-ca75-9589-612af6a2976c@users.sourceforge.net>
Message-ID: <20160615184306.GX11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 08:24:03PM +0200, SF Markus Elfring wrote:
> > http://webglimpse.net/
> > Its vaguely mentioned there. That's as good as it gets...
> 
> How do you think about to insert the date "2014-09-26" into your commit
> message?

Sure.

> >> https://github.com/gvelez17/glimpse/
> > Sadly the original release didn't compile, I reported the issue in hopes it would
> > be fixed. Nothing has happened since and I got tired of waiting so I forked
> > and fixed it myself.
> 
> I am also curious on further improvements for this software.
> How will corresponding constructive feedback evolve?

Beats me. As I see it no one cares over this software now, it would seem
some folks have used it in proprietary crap and those versions are much
better. To me what we can best do is see what we can take out of agrep,
and port it to proper GNU grep, then see if git can also enable complex
queries as Julia notes.

Patches to those projects welcomed I'm sure.

  Luis
