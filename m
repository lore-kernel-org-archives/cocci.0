From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 24 Jan 2013 19:05:45 +0100 (CET)
Subject: [Cocci] Prepending '*' to an expression (Was: [PATCH V2]
 scripts/coccinelle/misc/memcpy-assign.cocci: Replace memcpy with struct
 assignment)
In-Reply-To: <510173B3.9090002@redhat.com>
References: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
 <510173B3.9090002@redhat.com>
Message-ID: <alpine.DEB.2.02.1301241900190.2449@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 24 Jan 2013, Michael Stefaniuc wrote:

> Hello,
>
> On 01/23/2013 11:06 PM, Peter Senna Tschudin wrote:
> > There are error-prone memcpy() that can be replaced by struct
> > assignment that are type-safe and much easier to read. This semantic
> > patch looks for memcpy() that can be replaced by struct assignment.
> thanks for the script by Peter this script as it proved useful for Wine
> too. Though in one case it generated the wrong patch.
>
> @@
> struct struct_name to;
> struct struct_name from;
> @@
>
> 'to' and 'from' above are expressions and not identifiers; that's a
> feature. The bug happened in the replacement
> - memcpy(foos + count, &foo, sizeof(struct foo_t));
> + *foos + count = foo;
>
> Shouldn't cocinelle automatically add the parenthesis when prepending a
> '*' or '&' to an expression which isn't an identifier?

Perhaps it would be possible, but there is nothing in place to do that.

Part of a solution would be to declare the metavariable in the
unparenthesized case as an idexpression, ie idexpression struct
struct_name *to.  Then one could have a rule for an arbitrary expression
afterwards, ie with the metavariable declaration above, that would
explicitly add parentheses.

With that though you would end up with parentheses around eg x->y, because
that is not considered to be an identifier.  So one would also need a
separate rule in the middle for that case.  To ensure that the types are
OK, you should be able to do:

@@
struct struct_name *to;
expression e;
identifier f;
...
@@

  e->f at to

This should match the same term against both the pattern e->f and the
pattern to.

Thanks for testing.

julia
