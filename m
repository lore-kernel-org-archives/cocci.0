From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 11 Apr 2014 21:40:40 +0200
Subject: [Cocci] Software parallelisation?
In-Reply-To: <CAGrdgiUtFnTCH+HmhfLhxTmp=btBqx3mYJGQLN6AeaUnxW=YSw@mail.gmail.com>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
 <alpine.DEB.2.02.1404102131390.2201@localhost6.localdomain6>
 <5347ACF3.9040308@users.sourceforge.net>
 <CAGrdgiUtFnTCH+HmhfLhxTmp=btBqx3mYJGQLN6AeaUnxW=YSw@mail.gmail.com>
Message-ID: <53484538.9040104@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Ocaml is not multi-threaded because it does not have a garbage collector able
> to execute in multiple threads at the same time. This is being worked on
> seriously now, but is at least 2-3 years out on the horizon for a stable solution.

Would you like to point out any concrete discussions about corresponding
software evolution?


> So to make cocci faster on the inside requires some multi-processing hackery.
> Certainly possible, but not as easy.

I imagine that more fine-tuning could be performed for basic data structures.
Which ideas have you got in mind for improvements around multi-programming
approaches here?

Regards,
Markus
