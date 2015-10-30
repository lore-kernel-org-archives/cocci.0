From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 30 Oct 2015 17:06:04 +0100 (CET)
Subject: [Cocci] Release 1.0.3: Clarification around SmPL conjunctions
In-Reply-To: <563390EE.1000306@users.sourceforge.net>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <5631F344.9080804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301405330.2364@hadrien>
 <56337A59.8030804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301535230.2364@hadrien>
 <563383DF.9000509@users.sourceforge.net>
 <alpine.DEB.2.10.1510301606020.2364@hadrien>
 <56338C69.3030401@users.sourceforge.net>
 <alpine.DEB.2.10.1510301643040.2364@hadrien>
 <563390EE.1000306@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1510301705060.2364@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 30 Oct 2015, SF Markus Elfring wrote:

> > The code is not intended to be run.
>
> I guess that a duplicate function name can result in unwanted data
> from the analysis for a source file like "demos/conjunction.c", can't it?

No idea what you mean by that.  demos/conjunction.c is only intended for
use with demos/conjunction.cocci, which doesn't care at all about the name
of the containing function.

julia
