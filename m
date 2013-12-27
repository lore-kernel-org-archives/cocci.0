From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 27 Dec 2013 11:37:58 +0100
Subject: [Cocci] simple scanner question
In-Reply-To: <alpine.DEB.2.02.1312271118070.1979@localhost6.localdomain6>
References: <20131227094634.GA10062@opentech.at>
 <alpine.DEB.2.02.1312271118070.1979@localhost6.localdomain6>
Message-ID: <20131227103758.GA11874@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 27 Dec 2013, Julia Lawall wrote:

> > @assign@
> > expression s,var;
> > position p1,p2,p3;
> > statement S1;
> > identifier func,member;
> > @@
> > 
> > ...func at p1(...){
> 
> You don't need the ... before func.  I guess you were worried about the 
> return type, visibility modifiers, etc.  You can just omit them.
> 
> > ...
> >  var = s->member at p2;
> 
> Here there should be no semicolon.  The semicolon means that the pattern 
> should be a complete statement.  In your code, the assignment is part of:
> 
> struct transaction *t = ec->curr;
>

looks like that ; was my problem !
 
> so there is more to the complete statement than the assignment.
> 
> > ...
> >  spin_lock_irqsave at p3(s->lock,...);
> 
> The example code is:
> 
> spin_lock_irqsave(&ec->lock, flags);
> 
> It looks like what is to the left of the -> is just an expression, but it 
> is not due to the relative priority of & and ->.  That is, it is not
> 
> (&ec) -> lock
> 
> it is:
> 
> &(ec -> lock)
> 
> So you need the & in your pattern.  If there are cases where the structure 
> really contains a pointer to a lock, then you might want to put
> 
> \(&s->lock\|s->lock\)
> 
> in place of s->lock.
> 
> Then it should be OK :)
>
thanks for the clarification - up and running.
 
thx!
hofrat
 
