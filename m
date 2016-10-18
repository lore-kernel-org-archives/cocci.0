From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Oct 2016 07:37:15 +0200 (CEST)
Subject: [Cocci] Problems in translating collateral evolutions to SmPL
In-Reply-To: <87h98a1i8o.fsf@enight.me>
References: <87h98a1i8o.fsf@enight.me>
Message-ID: <alpine.DEB.2.20.1610180727460.2038@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 18 Oct 2016, Junjie Mao wrote:

> Hi all,
>
> I'm recently collecting collateral evolutions in Linux, inferring the
> patterns in these patches and generate semantic patches for maintainers
> of out-of-tree modules. During the work I am not sure how to express the
> following cases in SmPL.
>
> 1. add a reader for a structure field
>
>     For example, in the following code
>
>      1   int foo(struct device* dev, int mask) {
>      2       int old_flags = dev->flags;
>      3       dev->flags &= mask;
>      4       return (dev->flags == old_flags);
>      5   }
>
>     'dev->flags' need to be replaced by 'dev_flags(dev)' where
>     dev_flags(dev) is a function returning 'dev->flags'. The following
>     semantic patch:
>
>      @@
>      struct device *dev;
>      @@
>      -dev->flags
>      +dev_flags(dev)
>
>     will rewrites all occurences of 'dev->flags', including the one on
>     line 3, which makes the program incorrect. How can I avoid touching
>     line 3 while updating line 2 and line 4 using spatch?

(
dev->flags = e
|
- dev->flags
+ dev_flags(dev)
)

A disjunction should take the first pattern that matches.

>
>     Related commits:
>     - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2f064f3485cd29633ad1b3cfb00cc519509a3d72
>     - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4d0e965732db6f7cce78e6b8f5d3073249004c3a
>
> 2. rewriting part of a branch condition
>
>      int foo(int i, int j) {
>          if (i > 3 && i < 10 && j > 5 && j < 8)
>              return i;
>          return j;
>      }
>
>     If a commit replaces (i < 10 && j > 5) with (i < 8) (the order of
>     comparisons and logical operators are fixed), how can I express this
>     pattern in SmPL?
>
>     I have tried the following, but it does not work.
>
>      @@
>      identifier foo, i, j;
>      @@
>       foo(int i, int j) {
>           <...
>      -    i < 10 && j > 5
>      +    i < 8
>           ...>
>       }
>
>     Related commit:
>     - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=dc3f4198eac14e52a98dfc79cd84b45e280f59cd

This is due to how the && is parsed. a && b && c && d is either parsed as
((a && b) && c) && d or a && (b && (c && d)) (I don't remember which), but
neither has b && c as a sub parse tree.  I think that the only possibility
here is to make some special cases.

> 3. add a statement right after local variable declarations
>
>     In the following function,
>
>      int foo(int i) {
>          int j,k,l;
>
>          j = baz(i);
>          ...
>      }
>
>     How can I add the statement 'bar(i);' before 'j = baz(i)' but after
>     the local variable declarations?

f(...) {
   ... when != S
+  newcode
   S1
   ...
}

Declarations don't match S (statement metavariable).


>     Related commit:
>     - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=54efd50bfd873e2dbf784e0b21a8027ba4299a3e
>
> 4. change callback prototypes
>
>     Assume a driver defines a global structure initialized with
>     callbacks:
>
>      1   int foo(int i, int j) { ... }
>      2   int bar(int i, int j) { ... }
>      3
>      4   struct netdev_ops ops = {
>      5       .foo = foo,
>      6   };
>
>     and a commit requires the prototype of the callback being changed to
>     foo(int i, int j, intk), how can I achieve that without touching
>     bar() using spatch?

@r@
identifier i,f;
@@

struct netdev_ops i = { .foo = f, };

@@
identifier r.f;
@@

Now do whatever you want with f

---

julia


>     Related commit:
>     - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=88e72717c2de4181d8a6de1b04315953ad2bebdf
>     - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=dece16353ef47d8d33f5302bc158072a9d65e26f
>
> --
> Best Regards
> Junjie Mao
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
