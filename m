From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Dec 2012 08:33:12 +0100 (CET)
Subject: [Cocci] Inter-procedural analysis.
In-Reply-To: <50D6269D.2060702@gmail.com>
References: <50D61A69.106@gmail.com>
 <alpine.DEB.2.02.1212222145390.1954@hadrien> <50D6269D.2060702@gmail.com>
Message-ID: <alpine.DEB.2.02.1212230827130.2003@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 22 Dec 2012, Cyril Roelandt wrote:

> On 12/22/2012 09:49 PM, Julia Lawall wrote:
> > On Sat, 22 Dec 2012, Cyril Roelandt wrote:
> >
> > > Hello!
> > >
> > > I was trying to find cases of double mutex unlocks in the Hurd, and wrote
> > > a
> > > very simple semantic patch:
> > >
> > > @exists@
> > > expression E;
> > > @@
> > > * pthread_mutex_unlock(E);
> > > ... when != pthread_mutex_lock(E)
> > > * pthread_mutex_unlock(E);
> > >
> > > This works as expected with this snippet of C code:
> > >
> > > static void
> > > foo(void)
> > > {
> > > 	pthread_mutex_lock(&lock);
> > > 	do_stg();
> > > 	pthread_mutex_unlock(&lock);
> > > 	if (some_condition)
> > > 		pthread_mutex_unlock(&lock);
> > > }
> > >
> > > --- x.c
> > > +++ /tmp/cocci-output-4955-ff7d08-x.c
> > > @@ -3,7 +3,5 @@ foo(void)
> > >   {
> > >   	pthread_mutex_lock(&lock);
> > >   	do_stg();
> > > -	pthread_mutex_unlock(&lock);
> > >   	if (some_condition)
> > > -		pthread_mutex_unlock(&lock);
> > >   }
> > >
> > > But it will report a false positive with this code:
> > >
> > > static void
> > > lock_it(pthread_mutex_t *lock)
> > > {
> > > 	pthread_mutex_lock(lock);
> > > }
> > >
> > > static void
> > > foo(void)
> > > {
> > > 	pthread_mutex_lock(&lock);
> > > 	do_stg();
> > > 	pthread_mutex_unlock(&lock);
> > > 	lock_it(&lock);
> > > 	pthread_mutex_unlock(&lock);
> > > }
> > >
> > > It is perfectly fine to call pthread_mutex_unlock the second time, since
> > > LOCK
> > > has been re-acquired by lock_it(). Is there any way to do inter-procedural
> > > analysis in a semantic patch ?
> >
> > I'm not sure that I see anything that would be particularly pleasant.  If
> > this code is typical, perhaps you could just put when != E on the dots?
> >
>
> I could do this, but sometimes, things get a little bit more complicated:
>
> struct foo {
> 	pthread_mutex_t *lock;
> };
>
> ...
>
> static void
> bar(struct foo *f)
> {
> 	pthread_mutex_unlock(f->lock);
> 	do_stg(f);
> 	pthread_mutex_unlock(f->lock);
> }
>
> Here, do_stg() may or may not acquire f->lock, but excluding uses of "f"
> between calls to pthread_mutex_unlock() would probably make us miss bugs.
>
> > Does this happen a lot?
>
> No, and anyway, locking issues are always quite complicated, so the patches
> must be reviewed, and it is not so bad to have a few false positives.
>
> I was just curious, and wondering if it would be possible to have a bunch of
> pthread-related semantic patches "ready-to-use" for people who are not
> familiar with Coccinelle, in which case handling such cases would have been
> nice.

The problem is that one doesn't know which function to unfold, or how
much.  It could go quite far.

On coccinellery.org there is the semantic patch o_lock_inconsistent.cocci,
which could be useful in general for locks.  It tries to find the case
where the lock is unlocked on some paths and not unlocked on others.  It
tries to take into account the case where both the lock and unlock are
under the same tests.

julia
