From: tipecaml@gmail.com (Cyril Roelandt)
Date: Sat, 22 Dec 2012 21:39:05 +0100
Subject: [Cocci] Inter-procedural analysis.
Message-ID: <50D61A69.106@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello!

I was trying to find cases of double mutex unlocks in the Hurd, and 
wrote a very simple semantic patch:

@exists@
expression E;
@@
* pthread_mutex_unlock(E);
... when != pthread_mutex_lock(E)
* pthread_mutex_unlock(E);

This works as expected with this snippet of C code:

static void
foo(void)
{
	pthread_mutex_lock(&lock);
	do_stg();
	pthread_mutex_unlock(&lock);
	if (some_condition)
		pthread_mutex_unlock(&lock);
}

--- x.c
+++ /tmp/cocci-output-4955-ff7d08-x.c
@@ -3,7 +3,5 @@ foo(void)
  {
  	pthread_mutex_lock(&lock);
  	do_stg();
-	pthread_mutex_unlock(&lock);
  	if (some_condition)
-		pthread_mutex_unlock(&lock);
  }

But it will report a false positive with this code:

static void
lock_it(pthread_mutex_t *lock)
{
	pthread_mutex_lock(lock);
}

static void
foo(void)
{
	pthread_mutex_lock(&lock);
	do_stg();
	pthread_mutex_unlock(&lock);
	lock_it(&lock);
	pthread_mutex_unlock(&lock);
}

It is perfectly fine to call pthread_mutex_unlock the second time, since 
LOCK has been re-acquired by lock_it(). Is there any way to do 
inter-procedural analysis in a semantic patch ?

Cyril Roelandt.
