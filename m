From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 25 Apr 2014 16:30:30 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
Message-ID: <535A7186.1020301@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I was wondering if the change I'm doing manually could be automated by
> using cocinelle but I've no experience neither writing semantic
> patches nor the SmPL language grammar.

I would like to point out a general consideration.

Semantic patches can be developed for some use cases. I find that
corresponding efforts are only useful if such a generalised patch can be
applied to a source code base several times.
I doubt that you want to try it out for a single source code adjustment.
It might be that a need will appear to perform a transformation once
more a bit later, doesn't it?

Regards,
Markus
