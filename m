From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Feb 2016 19:50:37 -0500 (EST)
Subject: [Cocci] --no-loops
In-Reply-To: <20160215175401.GA24839@osadl.at>
References: <20160215175401.GA24839@osadl.at>
Message-ID: <alpine.DEB.2.10.1602171948520.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Feb 2016, Nicholas Mc Guire wrote:

>
> Hi !
>
>  --no-loops is documented as:
> <snip>
>        --no-loops
>               drop all back edges derived from looping constructs - unsafe
> <snip>
>
>  the background is that some scanners will simply not make any
>  progress (e.g. linux-next/lib/rbtree.c:__rb_insert() is a perfect
>  "hang" without --no-loops for even simple scanners
>
>  what exactly does unsafe here mean ?

The correctness of a rules might require following back edges.  For
example,

a();
... when != b();

in code like

while (x) {
  b();
  a();
}
return;

With --no-loops, the rule above would match, while with loops taken into
account it should not.

julia
