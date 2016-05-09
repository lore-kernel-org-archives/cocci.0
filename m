From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 9 May 2016 23:24:42 +0200 (CEST)
Subject: [Cocci] Out of tree instrumentation with coccinelle demo
In-Reply-To: <20160509211011.GF14141@wotan.suse.de>
References: <CAB=NE6XrFxvTJrJVVLvT-4ii-UU-tgAqB=AgzgFH20prR1DoUA@mail.gmail.com>
 <572F27FF.7040301@oracle.com> <20160508192303.GB14141@wotan.suse.de>
 <alpine.DEB.2.02.1605082133430.2237@localhost6.localdomain6>
 <20160509211011.GF14141@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1605092313070.2057@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 9 May 2016, Luis R. Rodriguez wrote:

> On Sun, May 08, 2016 at 09:51:43PM +0200, Julia Lawall wrote:
> > On Sun, 8 May 2016, Luis R. Rodriguez wrote:
> > > @ find_drv_name @
> > > identifier drv;
> > > identifier mutex;
> > > @@
> > > 
> > > pthread_mutex_protects_3(&drv->mutex, ...);
> > > 
> > > @ find_hint @
> > > type T;
> > > T *drv;
> > > identifier mutex, item_1, item_2, item_3;
> > > @@
> > > 
> > > pthread_mutex_protects_3(&drv->mutex, drv->item_1, drv->item_2, drv->item_3);
> > 
> > Why do you need both of the above rules?  I think that the second one 
> > should be fine.
> 
> The second one infers the type but does not care for the location of
> drv, the first one is used to get the name of the global variable.
> We cannot share *drv from the second rule on further rules.

What global variable?  Why can't you use the drv from the second rule in 
other rules?

> > > @ find_pthread_fn depends on find_hint @
> > > identifier fn, ret;
> > > expression thread, attr, val;
> > > @@
> > > 
> > > ret = pthread_create(thread, attr, fn, val);
> > 
> > The connection to find_hint is rather weak here.  Is there any way that 
> > they could be better tied together?
> 
> The hint would be very application and domain specific, in the pthread case we
> could for instance extend the hint support to be pthread related and also
> require the hint to require the callback.
> 
> To make emphasis of this as a desired change I'll go ahead and do that
> but also document how this is application specific.
> 
> > > @ check_fn_access @
> > > identifier find_pthread_fn.fn;
> > > type find_hint.T;
> > > T *drv;
> > > identifier find_hint.item_1;
> > > identifier find_hint.item_2;
> > > identifier find_hint.item_3;
> > > @@
> > > 
> > > fn (...)
> > > {
> > > 	<+...
> > > (
> > > 	drv->item_1
> > > |
> > > 	drv->item_2
> > > |
> > > 	drv->item_3
> > > )
> > >         ...+>
> > > }
> > >
> > > @ check_helpers depends on find_pthread_fn @
> > > identifier helper;
> > > identifier find_pthread_fn.fn;
> > > identifier find_hint.mutex;
> > > type find_hint.T;
> > > T *drv;
> > > @@
> > > 
> > > fn (...)
> > > {
> > > 	<+... when != pthread_mutex_lock(&drv->mutex);
> > > 	helper(...);
> > > 	...+>
> > > }
> > 
> > The depends on should not be needed in the above two rules, because they 
> > can only match if fn has a value, which can only happen if find_pthread_fn 
> > matched.
> 
> Amended, thanks!
> 
> > In each case, fn is the callback function of the thread_create.  I guess 
> > it is the function to be run by the thread.
> 
> Right, each thread.
> 
> > The first rule looks for a 
> > direct reference to one of the protected fields.  The second rule looks 
> > for a call to another function, in the case where the protecting lock is 
> > not taken anywhere in the function.
> 
> Right. Its the same routine though, and now I understand why you mentioned
> that the hint was rather loose with respect to fn.
> 
> 
> > I'm surprised that there is no consideration of the lock in the first 
> > rule.  The rules seem to be doing sort of the same thing, but don't have 
> > the same constraints.
> 
> Right, so since fn is the same (but could have been any as you noted, but
> constrained in the iteration I posted to pthread_create()) I split this up to
> enable to query if fn made reference to any of the protected fields, separately
> from querying if fn had the lock but also had helpers.  Its certainly possible
> to combine them but I cared more for knowing the lock was not held during each
> helper's use. Since fn is the same for both (this is made stronger with the
> suggestion you made of making a stringer link, which I'm now implementing
> by requiring the hint to be explicit about the call that we'd start
> caring about the critical areas for), I could later ask simply if both
> cases were true, and likewise a mismatch of helpers with / without locks
> existed, then the right thing to do would be move to move the lock to
> the initial fn call.
> 
> Technically this would miss the case where fn() accesses the critical sections
> with a lock but does not hold the lock for the helpers. Will fix this then
> by joining the rules.
> 
> > But in general, I think that there are two cases that are wanted:
> > 
> > ... when != lock()
> > XXX
> > ... when any
> > 
> > and
> > 
> > ... when any
> > unlock()
> > ... when != lock()
> > XXX
> > ... when any
> > 
> > That is, in the first case there has been no lock yet and in the second 
> > case there was an unlock and there was no subsequent lock.
> 
> Yes, for simplicity, given this is just an example, can we just
> consense this as follows:
> 
> fn (...)
> {
> 	<+... when != \(pthread_mutex_lock(&drv->mutex)\|pthread_mutex_lock(&drv->mutex)\)
> (
> 	drv->item_1
> |
> 	drv->item_2
> |
> 	drv->item_3
> |
> 	helper(...)
> )
> 	...+>
> }
> 
> There may be more complex fn() where things get intertwined, for instance a
> lock here and there, but some code without a lock, but since this is an example,
> I think simply ensuring no lock is used at all is fair. Thoughts ?

This doesn't work.  Actually, the original check_helpers didn't work 
either.  The problem is that helper is inside a <+... ...+> and it is 
inherited by a later rule.  Due to the inheritance, there has to be a 
single value of helper that covers the entire rule.  But the function 
could call more than one helper function.  To allow that you need

... when any
helper(...)
... when any

You may as well further put exists on the rule header also.  Basically you 
want to consider each called function individually.

> > > @ helper_accessing_with_lock exists @
> > > identifier check_helpers.helper;
> > > type find_hint.T;
> > > T *drv;
> > > identifier find_hint.mutex;
> > > identifier find_hint.item_1;
> > > identifier find_hint.item_2;
> > > identifier find_hint.item_3;
> > > position p1, p2;
> > > @@
> > > 
> > > helper(...)
> > > {
> > > 	...
> > > 	pthread_mutex_lock at p1(&drv->mutex);
> > > 	<+...
> > > (
> > > 	drv->item_1
> > > |
> > > 	drv->item_2
> > > |
> > > 	drv->item_3
> > > )
> > >         ...+>
> > > 	pthread_mutex_unlock at p2(&drv->mutex);
> > > }
> > 
> > This requires the unlock to be at the end of the function.  The whole 
> > function body should be surrounded in <+... ...+>
> 
> Indeed, thanks.
> 
> > This is finding that everything is OK for the helper, because the helper 
> > has a lock of its own.
> 
> Correct.
> 
> > > @ helper_accessing_without_lock exists @
> > > identifier check_helpers.helper;
> > > type find_hint.T;
> > > T *drv;
> > > identifier find_hint.mutex;
> > > identifier find_hint.item_1;
> > > identifier find_hint.item_2;
> > > identifier find_hint.item_3;
> > > @@
> > > 
> > > helper(...)
> > > {
> > > 	<+... when != pthread_mutex_lock(&drv->mutex);
> > > (
> > > 	drv->item_1
> > > |
> > > 	drv->item_2
> > > |
> > > 	drv->item_3
> > > )
> > >         ...+>
> > > }
> > 
> > This one is finding that the helper is not correct, because it doesn't 
> > have a lock either, and it does have references.  See the above two 
> > patterns for a better way to match the case where the references are not 
> > in a lock.
> 
> Thanks.
> 
> > > @ remove_helper_lock @
> > > identifier check_helpers.helper;
> > > type find_hint.T;
> > > T *drv;
> > > identifier find_hint.mutex;
> > > identifier find_hint.item_1;
> > > identifier find_hint.item_2;
> > > identifier find_hint.item_3;
> > > position helper_accessing_with_lock.p1, helper_accessing_with_lock.p2;
> > > @@
> > > 
> > > helper(...)
> > > {
> > > 	...
> > > -	pthread_mutex_lock at p1(&drv->mutex);
> > > 	...
> > > -	pthread_mutex_unlock at p2(&drv->mutex);
> > > }
> > > 
> > > 
> > > @ fix_top_level @
> > > identifier find_pthread_fn.fn;
> > > identifier find_hint.mutex;
> > > identifier find_drv_name.drv;
> > > @@
> > > 
> > > fn (...)
> > > {
> > > +	pthread_mutex_lock(&drv->mutex);
> > > 	...
> > > +	pthread_mutex_unlock(&drv->mutex);
> > > }
> > 
> > Hmm, not sure to understand the goal of the above two rules.  Why do you 
> > want to put the lock around the entire body of the callback function?
> 
> Great question.
> 
> That's because the state machine used is a bit fragile, it requires
> that the thread state (party->tid_status[tid]) must be in sync with
> an action, in this case eat() or cleanup(). So there are two fixes
> to the locking of this program with the current sample implementation:
> 
> 0. Although the program has fed us hints about the critical section a
>    mutex protects it has not provided any hints about the state machine
>    used. When that's true, one can only assume all variables that are
>    critical could be part of the state machine as it is difficult
>    to infer what defines the state machine. If a state machine is used
>    and relied as part of the critical sections protected by a lock
>    its access must be held serially over full access to all other
>    critical variables. To see this one can try a simple fix by locking
>    only whenever any critical section is accessed, and see how it has
>    issues:
> 
> diff --git a/main.c b/main.c
> index 2fe9a0f9919f..3685d27425d3 100644
> --- a/main.c
> +++ b/main.c
> @@ -65,6 +65,7 @@ void cleanup(long tid)
>  	bool clean_follow = true;
>  	long t;
>  
> +	pthread_mutex_lock(&party->mutex);
>  	for (t=0; t < NUM_THREADS; t++) {
>  		if (t == tid)
>  			continue;
> @@ -75,13 +76,16 @@ void cleanup(long tid)
>  
>  	if (clean_follow)
>  		party->trash[tid] = 1;
> +	pthread_mutex_unlock(&party->mutex);
>  }
>  
>  void *thread_party(void *t)
>  {
>  	long tid = (long)t;
>  
> +	pthread_mutex_lock(&party->mutex);
>  	party->tid_status[tid] = THREAD_AT_PARTY;
> +	pthread_mutex_unlock(&party->mutex);
>  
>  	eat(tid);
>  
> @@ -90,7 +94,9 @@ void *thread_party(void *t)
>  
>  	cleanup(tid);
>  
> +	pthread_mutex_lock(&party->mutex);
>  	party->tid_status[tid] = THREAD_DONE;
> +	pthread_mutex_unlock(&party->mutex);
>  
>  	pthread_exit(NULL);
>  }
> 
>    With this in place all critical sections are now locked, however
>    there are still issues seen at run time. In lack of any information
>    about the state machine implementation one can only assume the worst,
>    and lock serially, as follows:
> 
> diff --git a/main.c b/main.c
> index 2fe9a0f9919f..1bd89b9186c0 100644
> --- a/main.c
> +++ b/main.c
> @@ -42,7 +42,6 @@ void eat(long tid)
>  	bool eat_in_order = true;
>  	long t;
>  
> -	pthread_mutex_lock(&party->mutex);
>  	/* If anyone ate out of place lets take notice of that... */
>  	for (t=0; t < NUM_THREADS; t++) {
>  		if (t == tid)
> @@ -57,7 +56,6 @@ void eat(long tid)
>  	if (party->food[tid])
>  		if (eat_in_order)
>  			party->food[tid] = 0;
> -	pthread_mutex_unlock(&party->mutex);
>  }
>  
>  void cleanup(long tid)
> @@ -81,6 +79,7 @@ void *thread_party(void *t)
>  {
>  	long tid = (long)t;
>  
> +	pthread_mutex_lock(&party->mutex);
>  	party->tid_status[tid] = THREAD_AT_PARTY;
>  
>  	eat(tid);
> @@ -91,6 +90,7 @@ void *thread_party(void *t)
>  	cleanup(tid);
>  
>  	party->tid_status[tid] = THREAD_DONE;
> +	pthread_mutex_unlock(&party->mutex);
>  
>  	pthread_exit(NULL);
>  }
> 
> 
>    This is the strategy the current SmPL patch tries to address.
> 
> 1. With access to state machine hints Coccinelle may be able
>    to do more, that would be step 2 in optimization for a solution
>    here, the outlook of the hint and SmPL patch should be considered
>    as a secondary step in evolving this instrumentation, but the
>    results are as follows:
> 
> diff --git a/main.c b/main.c
> index 2fe9a0f9919f..518b8c5c843b 100644
> --- a/main.c
> +++ b/main.c
> @@ -42,7 +42,6 @@ void eat(long tid)
>  	bool eat_in_order = true;
>  	long t;
>  
> -	pthread_mutex_lock(&party->mutex);
>  	/* If anyone ate out of place lets take notice of that... */
>  	for (t=0; t < NUM_THREADS; t++) {
>  		if (t == tid)
> @@ -57,7 +56,6 @@ void eat(long tid)
>  	if (party->food[tid])
>  		if (eat_in_order)
>  			party->food[tid] = 0;
> -	pthread_mutex_unlock(&party->mutex);
>  }
>  
>  void cleanup(long tid)
> @@ -81,16 +79,20 @@ void *thread_party(void *t)
>  {
>  	long tid = (long)t;
>  
> +	pthread_mutex_lock(&party->mutex);
>  	party->tid_status[tid] = THREAD_AT_PARTY;
>  
>  	eat(tid);
> +	pthread_mutex_unlock(&party->mutex);
>  
>  	if (tid % 2 == 1)
>  		sleep_random();
>  
> +	pthread_mutex_lock(&party->mutex);
>  	cleanup(tid);
>  
>  	party->tid_status[tid] = THREAD_DONE;
> +	pthread_mutex_unlock(&party->mutex);
>  
>  	pthread_exit(NULL);
>  }
> 
>    In this case the state machine, party->tid_status is only
>    locked serially against access helpers to the critical
>    sections.
> 
> > The weakness seems to be that helper has to be called directly from the 
> > callback function.
> 
> In this case yes, that is true.
> 
> > One would have to use iteration to trace the calls  down more deeply.
> 
> I see, thanks!
> 
> > Also, the whole set of rules would be needed for 1, 2, 3, ...  With 
> > iteration, one could schedule the work on the protected fields one by one, 
> > if the protection declaration could take any number of arguments.
> 
> Interesting, thanks. Its not clear how we could devise a strategy in C
> to enable overloading, if that's what you mean, otherwise I was not able
> to follow what you hinted at here.

pthread_mutex_protects_3(&drv->mutex, ..., drv->item, ...);

This will match in three ways, for the three drv->item arguments.  Care
would of course have to be taken to avoid ending up with triple locks and
unlocks.

But if in your use case, you always have three fields, then you may as well
make the rule specific to that.

julia
