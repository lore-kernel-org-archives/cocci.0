From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Dec 2012 21:49:30 +0100 (CET)
Subject: [Cocci] Inter-procedural analysis.
In-Reply-To: <50D61A69.106@gmail.com>
References: <50D61A69.106@gmail.com>
Message-ID: <alpine.DEB.2.02.1212222145390.1954@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 22 Dec 2012, Cyril Roelandt wrote:

> Hello!
>
> I was trying to find cases of double mutex unlocks in the Hurd, and wrote a
> very simple semantic patch:
>
> @exists@
> expression E;
> @@
> * pthread_mutex_unlock(E);
> ... when != pthread_mutex_lock(E)
> * pthread_mutex_unlock(E);
>
> This works as expected with this snippet of C code:
>
> static void
> foo(void)
> {
> 	pthread_mutex_lock(&lock);
> 	do_stg();
> 	pthread_mutex_unlock(&lock);
> 	if (some_condition)
> 		pthread_mutex_unlock(&lock);
> }
>
> --- x.c
> +++ /tmp/cocci-output-4955-ff7d08-x.c
> @@ -3,7 +3,5 @@ foo(void)
>  {
>  	pthread_mutex_lock(&lock);
>  	do_stg();
> -	pthread_mutex_unlock(&lock);
>  	if (some_condition)
> -		pthread_mutex_unlock(&lock);
>  }
>
> But it will report a false positive with this code:
>
> static void
> lock_it(pthread_mutex_t *lock)
> {
> 	pthread_mutex_lock(lock);
> }
>
> static void
> foo(void)
> {
> 	pthread_mutex_lock(&lock);
> 	do_stg();
> 	pthread_mutex_unlock(&lock);
> 	lock_it(&lock);
> 	pthread_mutex_unlock(&lock);
> }
>
> It is perfectly fine to call pthread_mutex_unlock the second time, since LOCK
> has been re-acquired by lock_it(). Is there any way to do inter-procedural
> analysis in a semantic patch ?

I'm not sure that I see anything that would be particularly pleasant.  If
this code is typical, perhaps you could just put when != E on the dots?

Does this happen a lot?

julia
