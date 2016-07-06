From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 6 Jul 2016 18:23:02 +0200 (CEST)
Subject: [Cocci] Adding missing parameter to function if missing
In-Reply-To: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
References: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
Message-ID: <alpine.DEB.2.10.1607061819400.3168@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @ test depends on !fn_with_user@
> identifier fn_with_user.fn;
> parameter list pl;
> expression E;
> @@
>
> fn(
> + my_type *foo,
> pl) {
> <+...
> bar(foo, E);
> ...+>
> }

This rule is contradictory.  You say that the rule fn_with_user should not
have matched, but you want to match the identifier fn_with_user.fn.
Instead, you should match fn first, then have one rule that matches the
case you don't want, and then finally the case that you do want:

@barfn@
identifier fn;
@@

fn(...) {
<+...
bar(...);
...+>
}

@fn_with_user@
identifier barfn.fn, foo;
typedef my_type;
parameter list pl;
expression E;
@@

fn(my_type *foo, pl) {
<+...
bar(foo, E);
...+>
}

@ test depends on !fn_with_user@
identifier barfn.fn;
parameter list pl;
expression E;
@@

fn(
+ my_type *foo,
pl) {
<+...
bar(foo, E);
...+>
}

When you match barfn, you create an environment for each possible value of
fn.  This is then passed through the next two rules, where it records
whether the rule fn_with_user matches.  There is a separate environment for
each match of barfn.

julia
