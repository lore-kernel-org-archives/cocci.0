From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 21 Jan 2016 12:02:12 +0100 (CET)
Subject: [Cocci] Filter out field names
In-Reply-To: <56A0A94A.9070702@monom.org>
References: <56A0A94A.9070702@monom.org>
Message-ID: <alpine.DEB.2.10.1601211138470.2530@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There are a bunch of problems, e,g. the hard coded type/names or the
> WARN_ON() should be put in front of the dereferences but that is something
> for later to improve. The main problem I face at this point is to filter
> out the spin_lock() and spin_unlock() access. All my attempts didn't let
> to the expected result. I think the best thing would be to match on the
> type. So if 'f' is of type spinlock_t ignore it. Any ideas how this
> could be expressed?

Here is my suggestion (see below for explanations):

@r@
identifier i, virtual.ty;
@@

struct ty *i;

@s@
identifier i,f,virtual.ty;
@@

f (...,struct ty *i,...) { ... }

@locks@
typedef spinlock_t;
spinlock_t *e;
statement S;
position p;
@@

e at S@p

@safe@
position p1;
identifier virtual.ty;
struct ty *x;
identifier f;
@@

 \(spin_lock\|spin_lock_irqsave\)(&x->lock,...)
 ... when != &x->lock
 x ->@p1 f

@depends on r || s@
identifier virtual.ty;
struct ty *x;
identifier f;
statement S;
position p != locks.p;
position p1 != safe.p1;
@@

(
++       WARN_ON(!lock_is_held(&x->lock.dep_map));
S at p
&
        x ->@p1 f
)

--------------------------------------------------------------------------

Same thing with explanations:

@r@
identifier i, virtual.ty;
@@

struct ty *i;

@s@
identifier i,f,virtual.ty;
@@

f (...,struct ty *i,...) { ... }

The above two rules look for files that contain declarations of your type
of interest.  If you are sure that the only files you care about modifying
contain this code, then including these rules will reduce running time very
substantially, because Coccinelle will only work on files that contain
these declarations.  Otherwise, it will work on all files, which will be
very slow, because your pattern is very generic.  Perhaps something to do
in a second step.


@locks@
typedef spinlock_t;
spinlock_t *e;
statement S;
position p;
@@

e at S@p

This finds all expressions that have type spinlock_t *, and stores their
position in p.  We will use this later to avoid transforming spin_lock
calls.  It would be nice if this could have been integrated into the later
rule, but that triggers some parsing problem.

@safe@
position p1;
identifier virtual.ty;
struct ty *x;
identifier f;
@@

 \(spin_lock\|spin_lock_irqsave\)(&x->lock,...)
 ... when != &x->lock
 x ->@p1 f

This is an optimization.  There is no point to add the WARN_ON if there was
a call to spin_lock on your lock just before.  You may want to add more
locking functions here.


@depends on r || s@
identifier virtual.ty;
struct ty *x;
identifier f;
statement S;
position p != locks.p;
position p1 != safe.p1;
@@

(
++       WARN_ON(!lock_is_held(&x->lock.dep_map));
S at p
&
        x ->@p1 f
)

This adds the WARN_ON before the code.  Using positions that should be
different than previously collected positions, this does not add WARN_ON on
statements that contain a lock somewhere, and does not add WARN_ON on
references where there was a lock call recently.

This should be run with at least the argument -D ty=typeofinterest.

Because this is looking for expressions of type spinlock_t *, it may be
useful to cause Coccinelle to take into account header files.  The
following options may be useful:

--recursive-includes --include-headers-for-types

Recursive includes causes not only files explicitly included, but also file
included by other includes to be taken into account.  If you think that
only explicitly included files would be good enough, then --all-includes
would be fine.  Include headers for types means that Coccinelle will look
at the header files for parsing and type information, but will not take
them into account during the transformation process.  This makes things
more efficient, if you don't think that transformations are needed in the
header files anyway.  The transformation being considered here would be
transformation of the header file in the context of the information
available in the .c file.  If you think that it would be useful to
transform the header file on its own, then you can use the argument
--include-headers.

An issue that remains is that you assume that the lock field has type
lock.  A quick grep in the Linux kernel shows that this is not always the
case.  You can make a virtual identifier for the lock field as well.  A
more complicated approach would be to have Coccinelle figure out the type
from the structure type definition.

A final issue is that my quick grep in the Linux kernel also shows that not
all locks are in structures.  But then it is less obvious how to connect
the locks to the protected references.

And thinking on, it is not always the case that because a structure has a
lock, that every field has to be accessed under a lock.  So in the end, it
may be necessary to do something even more clever.  For example,
if a field is somewhere referenced under a lock, and not referenced under a
lock in some other place, then perhaps that is more likely to be a real
problem.  But even that is not 100% certain, because there can be eg an
initialization phase that is not done concurrently, so no locks are
actually needed at that point, even though locks are needed elsewhere.

julia
