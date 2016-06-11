From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jun 2016 07:12:50 +0200 (CEST)
Subject: [Cocci] Making conjunctions smaller
In-Reply-To: <CAB=NE6V0etTQ+pAwGgsOQZc=z9wCDnJSCgPyRhCuN5DCp6Y+Bw@mail.gmail.com>
References: <CAB=NE6V0etTQ+pAwGgsOQZc=z9wCDnJSCgPyRhCuN5DCp6Y+Bw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1606110709340.2114@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 10 Jun 2016, Luis R. Rodriguez wrote:

> I have a series of changes, and I want to only make a subsequent
> change if and only if at least one of a series of previous declared
> rules were matched. I can do this by depends on foo1 || foo2 || foo3
> || foo4, etc however since I have a lot of rules I was hoping I could
> condense these into one. What would be the best way to do that?
> 
> This is just to reduce a long list of conjunctions to a much simpler set.

Disjunctions, I guess?

I guess you could make a rule that is guaranteed to match for some 
reason and put

@combined depends on a || b || c || d || e@
identifier f;
@@

f(...)

Here I match any function call, because any file of interest probably 
contains at least one.  But if possible it would be better to put a 
pattern that matches less often, because Coccinelle really will be doing 
the work of making these matches.

I think that the long list of ||s would be better.

julia
