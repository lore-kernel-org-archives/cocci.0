From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Aug 2015 12:30:36 -0700 (PDT)
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <55DA0DFD.8090005@users.sourceforge.net>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
 <55DA0DFD.8090005@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1508231227480.2916@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 23 Aug 2015, SF Markus Elfring wrote:

> > * -j should now work correctly.
>
> An incompatibility for the SmPL rules "initialize" and "finalize"
> is mentioned in the manual.
> https://github.com/coccinelle/coccinelle/blob/a46bef70162d17cec6b0fc6101d737989f735ee4/docs/manual/spatch_options.tex#L673
>
> Can this software limitation be explained better there?

There is no shared memory in ocaml.  initialize and finalize naturally
suggest that locations created in initialize can all be collected in a
single execution of finalize. Since this is not possible, initialize and
finalize are not allowed.  If you are OK with disjoint memory spaces per
thread, just use the existing script for parallelism.

>
>
> Does the parallelisation support need any more fine-tuning?
> * How often is task preparation required before further data processing
>   can be performed in parallel?
>
> * Which programming interfaces do you prefer for the storage
>   of collected data in the fork-join work flow?

No idea what either of these questions mean, but the whole point is that
there is no join.

julia
