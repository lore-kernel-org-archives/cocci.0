From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 10 Jun 2016 15:51:53 -0700
Subject: [Cocci] Making conjunctions smaller
Message-ID: <CAB=NE6V0etTQ+pAwGgsOQZc=z9wCDnJSCgPyRhCuN5DCp6Y+Bw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have a series of changes, and I want to only make a subsequent
change if and only if at least one of a series of previous declared
rules were matched. I can do this by depends on foo1 || foo2 || foo3
|| foo4, etc however since I have a lot of rules I was hoping I could
condense these into one. What would be the best way to do that?

This is just to reduce a long list of conjunctions to a much simpler set.

  Luis
