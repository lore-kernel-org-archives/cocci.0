From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Dec 2015 16:11:14 +0100 (CET)
Subject: [Cocci] Coccinelle for other programming languages
In-Reply-To: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C282@Mail1.FCMD.local>
References: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512171825240.10291@hadrien>
 <20151217221143.GV20409@wotan.suse.de>
 <5673BF55.4010902@users.sourceforge.net>
 <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C282@Mail1.FCMD.local>
Message-ID: <alpine.DEB.2.10.1512181603050.2499@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 18 Dec 2015, Dharmalingam Ganesan wrote:

> Hi,
>
> What is the effort it will take to come up with a Coccinelle for dynamic
> languages such as Python, JavaScript, etc.
>
> Which parts of Coccinelle would require customization, rework, etc.

Pretty much everything.  The whole thing is built on an abstract syntax
tree (embedded into a control-flow graph), so almost all of the code is
determined by the various productions of the abstract syntax tree.  Of
course, many kinds of syntax found in C have counterparts in other
languages, so the work would mostly be tedious rather than hard.

Working on a dynamic language shouldn't make that much difference.  There
will just be no types; types have turned out to be often useful when
working on the Linux kernel.

Finally, interprocedural analysis with Coccinelle is somewhat awkward.
This hasn't been too much of an issue for the Linux kernel, where most of
the functions are large, but it could be a problem for other programming
styles.

julia
