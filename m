From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Jun 2017 20:40:24 +0200 (CEST)
Subject: [Cocci] First try of coccinelle, needs advice
In-Reply-To: <1497718065.22624.152.camel@linux.intel.com>
References: <1497718065.22624.152.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.20.1706171909140.2169@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Jun 2017, Andy Shevchenko wrote:

> Hi!
>
> I played first time with coccinelle.
> What I have tried to do is to find all locations where pm_runtime_get()
> is not followed by pm_runtime_put() in case of error path.
>
> cocci script roughly does what I need, though I have several questions:
> - how to shrink it (I see few duplications there, no idea what is the
> best approach to eliminate them)?
> - how handle goto:s properly? I mean how to clearly choose goto path
> over the rest?
> - if you look at the result (see below) in almost all goto cases I need
> to avoid adding pm_runtime_put*() variants since it seems the error
> handling is broken (needs to shuffle error labels). How to achieve this?
> - any other recommendations or links to some good examples or
> documentation would be much appreciated

To start with, what are you trying to do in the last rule with the return
...; followed by return ret;?  Actually, Coccinelle is following the
control flow, so nothing would ever follow a return.

If you wanted to just detect the problem, but not fix it automatically,
then you could have the quite concise rule:

@@
expression ret,dev;
@@

*	ret = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
	if (ret < 0) {
		... when != pm_runtime_put(dev)
		    when != pm_runtime_put_sync(dev)
		    when != pm_runtime_put_autosuspend(dev)
		    when != pm_runtime_put_noidle(dev)
		    when != pm_runtime_put_sync_suspend(dev)
		    when != pm_runtime_put_sync_autosuspend(dev)
*		return ...;
	}

It could be good to run this to get an idea of what the possible cases are.

The ... will jump over gotos in this case.

The put functions seem to return values.  Thus they might appear as eg ret
= pm_runtime_put(dev).  Thus, I dropped the ;s after these calls to allow
them to appear as subexpressions.

ret can be any expression.  It doesn't have to be an identifier (single
variable name).

I assume that the argument to the get function has to have type struct
device *.  If that is the case, then it is better to leave out the type
information.  If it is not there, then Coccinelle won't have to check it.
Checking the type could require information fron header files, which is
expensive to collect.

Note that you don't need the outer parentheses that are in your rules.
Those are only needed when there are multiple cases in a single rule
(disjunction), but you have only one case in the rule.

You might want if ( \(ret < 0 \| ret != 0\) ) on the second line, in case
people test for failure in multiple ways.  ret != 0 will also match just
ret.

For fixing, an idea for a goto rule could be the following, which exploits
an existing label:

@@
expression dev,ret;
identifier l1,l2;
position p;
identifier f;
@@

f(...) { ... when any
        ret@p = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
        if (ret < 0) {
           ... when != pm_runtime_put(dev)
-          goto l1;
+          goto l2;
        }
        ... when any
            when exists
l2:     pm_runtime_put(dev);
l1:
	... when any
}

@@
identifier r.f,r.l1;
statement S;
@@

f(...) { <... when != goto l1;
-l1:
  S
...>
}

You would need to add in all the when's again, that I dropped to make the
idea more apparent.  Maybe there should be a big disjunction of freeing
functions at l2 as well?  There is also the possibility that the freeing
function will be on the right hand side of an assignment.

The second rule drops the label l1 if it is now useless.

After that rule, you can also have:

@@
expression dev,ret;
identifier l1;
statement S;
@@

        ret = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
	if (ret < 0) {
           ... when != pm_runtime_put(dev)
           goto l1;
        }
        ... when any
            when exists
+l1:
       pm_runtime_put(dev);
-l1:   S

This catches the case where there is no pre-existing label in the right place.

You could end with:

@r3@
expression dev,ret;
position p;
@@

        ret at p = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
        if (ret < 0) {
           ... when != pm_runtime_put(dev)
           return ...;
        }

@@
expression r3.dev,r3.ret;
position r3.p;
identifier l;
@@

        ret at p = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
(
        if (ret < 0) {
           ...
(
+          pm_runtime_put(dev);
           goto l;
|
+          pm_runtime_put(dev);
           return ...;
)
        }
|
        if (ret < 0)
+       {
+          pm_runtime_put(dev);
           goto l;
+       }
|
        if (ret < 0)
+       {
+          pm_runtime_put(dev);
           return ...;
+       }
)

The first rule checks that there is no put between the if and the return.
The ... will skip over gotos, to ensure that there is no put all the way
until the end of the function.  Then the second rule adds the put just
before the ending goto or return.  In the goto case, it might be wanted to
put the put@the goto label, instead of before the goto.  That would
require checking that no one else reaches that label.  Perhaps that is
better checked by hand.  It would depend on how many cases are affected.

julia
