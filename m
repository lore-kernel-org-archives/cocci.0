From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 May 2015 15:29:17 +0200 (CEST)
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <20150505130405.GA1956@opentech.at>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
 <5548B87B.4060103@users.sourceforge.net> <20150505130405.GA1956@opentech.at>
Message-ID: <alpine.DEB.2.10.1505051528520.2640@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 5 May 2015, Nicholas Mc Guire wrote:

> On Tue, 05 May 2015, SF Markus Elfring wrote:
>
> > > Check if the signature of a function and the return value type match.
> >
> > Is this a task that is usually performed by a compiler?
> >
> >
> > > In many cases this mismatch will have no side-effects
> > > but in some cases it may lead to hard to locate problems
> >
> > It is another software development challenge to find concrete
> > open issues there.
> >
> >
> > > - and for readability and code understanding it is also helpful
> > > when types match.
> >
> > How would you like to check for compatible data types here?
> >
>
> coccinelle knows the type so all you need to do is comare them in
> phython .
>
> >
> > > The output is a bit lengthy - not sure if that is too much
> > > but it seemed useful to me to see the non-matching types explicitly
> > > in the warning message.
> >
> > How do you think about to import the result list into a database table?
> >
>
> working on that "re-cycling" your parameter count example
> top 10:
>     488 ssize_t != int
>     195 int != unsigned int
>     183 long != int
>     113 int != u32
>      55 int != unsigned long
>      48 int != u8
>      45 int != u16
>      44 unsigned int != int
>      37 int != s32
>      30 int != long

Thanks for the specific results.  That looks very useful.

julia

>
>
> >
> > > +if T1 != T2:
> > > +   print "%s:%s,%s WARNING: return of wrong type (%s != %s)" % (p[0].file,fn,p[0].line,T1,T2)
> >
> > Is such a check a bit too simple?
> >
> Nop - why ?
> Cocci "knwow" C so the assignment of types is reliable -
> flaging a s32 != int is fine with respect to readability
> even if they are technically the same.
>
> thx!
> hofrat
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
