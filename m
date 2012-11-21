From: tipecaml@gmail.com (Cyril Roelandt)
Date: Thu, 22 Nov 2012 00:51:19 +0100
Subject: [Cocci] [Review needed] Ensure that calls to d_find_alias() are
 followed by dput().
In-Reply-To: <alpine.DEB.2.02.1211092221370.2302@localhost6.localdomain6>
References: <509B0B81.50304@gmail.com>
 <alpine.DEB.2.02.1211080820540.1945@localhost6.localdomain6>
 <509C118D.3010109@gmail.com>
 <alpine.DEB.2.02.1211092221370.2302@localhost6.localdomain6>
Message-ID: <50AD68F7.7050607@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 11/09/2012 10:29 PM, Julia Lawall wrote:
> I have attached a new version. I put some more headers at the top of the
> file. For the Confidence you should put High, Moderate, or Low. I put
> Moderate, but perhaps you will think that something else is better.
>

Thanks!

> Exists causes the rule to match when there is a single control-flow path
> through the function that satisfies the specified pattern. Without it,
> all paths from the first thing that matches are required to match the
> pattern, unless * is used (context mode).
>
> <... P ...> allows 0 or more occurrences of P within the path matched by
> <... ...>. It is just like ... except that it allows the occurrences of
> P (that you might want to modify, collect the position of etc.)
>
> <+... P ...+> is like <... P ...> except that it requires that there is
> at least one occurrence of P in the control-flow path.
>

Ok, thanks for your explanation.

> I am not sure that Peter's false positive is really a false positive.
> The missing dput is at the beginning of the function, whereas the patch
> addressed the end of the function. Perhaps the author of the patch
> thought about the function an realized that a dput wasn't needed at the
> beginning. But the patch at least doesn't say why.
>

Indeed, it was not a false positive, the patch got applied in -mm recently.

> Semantic patches for integration into Linux should be sent to Michal
> Marek <mmarek@suse.cz>, as well as to the people at COCCINELLE/Semantic
> Patches (SmPL) in MAINTAINERS.
>

Ok, I did that, thanks a lot.


Cyril Roelandt.
