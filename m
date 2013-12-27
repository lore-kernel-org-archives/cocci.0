From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Dec 2013 11:22:42 +0100 (CET)
Subject: [Cocci] simple scanner question
In-Reply-To: <20131227094634.GA10062@opentech.at>
References: <20131227094634.GA10062@opentech.at>
Message-ID: <alpine.DEB.2.02.1312271118070.1979@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @assign@
> expression s,var;
> position p1,p2,p3;
> statement S1;
> identifier func,member;
> @@
> 
> ...func at p1(...){

You don't need the ... before func.  I guess you were worried about the 
return type, visibility modifiers, etc.  You can just omit them.

> ...
>  var = s->member at p2;

Here there should be no semicolon.  The semicolon means that the pattern 
should be a complete statement.  In your code, the assignment is part of:

struct transaction *t = ec->curr;

so there is more to the complete statement than the assignment.

> ...
>  spin_lock_irqsave at p3(s->lock,...);

The example code is:

spin_lock_irqsave(&ec->lock, flags);

It looks like what is to the left of the -> is just an expression, but it 
is not due to the relative priority of & and ->.  That is, it is not

(&ec) -> lock

it is:

&(ec -> lock)

So you need the & in your pattern.  If there are cases where the structure 
really contains a pointer to a lock, then you might want to put

\(&s->lock\|s->lock\)

in place of s->lock.

Then it should be OK :)

julia

>  if(!var)
>   S1
>  ...
> }
> 
> @script:python@
> p1 << assign.p1;
> p2 << assign.p2;
> p3 << assign.p3;
> fn << assign.func;
> @@
> 
> print "%s:%s possible assign without lock at lines %s (related ? lock at line %s)" % (p1[0].file,fn,p2[0].line,p3[0].line)
> 
> but this simply does not trigger in the above code snippet. 
> 
>  root at rtl15:/usr/src/3.12.5-rt7# spatch -sp_file race3.cocci drivers/acpi/ec.c
>  init_defs_builtins: /usr/local/share/coccinelle/standard.h
>  HANDLING: drivers/acpi/ec.c
> 
> Can someone point me to my missunderstanding of coccinelle ?
> 
> thx!
> hofrat
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
