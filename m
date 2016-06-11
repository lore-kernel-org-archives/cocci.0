From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 11 Jun 2016 08:38:39 +0200
Subject: [Cocci] Making conjunctions smaller
In-Reply-To: <CAB=NE6V0etTQ+pAwGgsOQZc=z9wCDnJSCgPyRhCuN5DCp6Y+Bw@mail.gmail.com>
References: <CAB=NE6V0etTQ+pAwGgsOQZc=z9wCDnJSCgPyRhCuN5DCp6Y+Bw@mail.gmail.com>
Message-ID: <505172b0-ca2d-d7c3-0b65-465c5374735a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I can do this by depends on foo1 || foo2 || foo3|| foo4,
> etc however since I have a lot of rules

How many condition elements have you got in mind for your use case?

Does the mentioned SmPL dependency specification become inconvenient (or
challenging) occasionally?


> I was hoping I could condense these into one.

Would you like to construct dependencies by special scripts?


> This is just to reduce a long list of conjunctions to a much simpler set.

Are you eventually looking for the support of another metavariable type
in the semantic patch language?

Regards,
Markus
