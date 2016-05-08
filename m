From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Sun, 8 May 2016 21:23:03 +0200
Subject: [Cocci] Out of tree instrumentation with coccinelle demo
In-Reply-To: <572F27FF.7040301@oracle.com>
References: <CAB=NE6XrFxvTJrJVVLvT-4ii-UU-tgAqB=AgzgFH20prR1DoUA@mail.gmail.com>
 <572F27FF.7040301@oracle.com>
Message-ID: <20160508192303.GB14141@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, May 08, 2016 at 07:50:23AM -0400, Sasha Levin wrote:
> On 05/06/2016 07:26 PM, Luis R. Rodriguez wrote:
> > Julia and I had discussed the possibility to instrument Linux code as
> > an alternative to complex debugging strategies (lockdep is one) that
> > often may be frowned upon due to how intrusive some changes may be or
> > how much extra stuff would be needed upstream. It has been hard to
> > explain the idea to folks who might make some use of it so I've gone
> > ahead and created a demo tree for userspace code that shows some basic
> > instrumentation ideas. You can fetch it here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/cocci-tact.git
> 
> Thanks Luis! I haven't reviewed it yet, just Cc'ing Quentin and Vegard
> who are also working on the lock poisoning patchset.

Another strategy can be to do instrumentation internally in Coccinelle
with the help of its standard rule dependency or extending use by
using Python scripting for a replacement for internall book keeping.

The patch below is a simple alternative to adding C instrumentation
code but instead it actually tries to fix the code given a certain
set of conditions and rules.

The cocci script doesn't work yet as I haven't figured out how to tell
coccinelle what is needed, but I'm confident its posible:

  * remove_helper_lock rule should take effect if
    helper_accessing_with_lock was found, but so was
    helper_accessing_without_lock, check_helpers,
    check_fn_access.

  * Likewise for fix_top_level -- we want to add the lock
    to the top level if helpers of both types were found,
    one which adds a lock and others which missed it

Oh and I forgot to place the unlock before pthread_exit() but
that's an easy fix. It should be possible to address all
these requirements within coccinelle, its just not clear
right now to me exactly how -- perhaps python variables?

  Luis

@ find_drv_name @
identifier drv;
identifier mutex;
@@

pthread_mutex_protects_3(&drv->mutex, ...);

@ find_hint @
type T;
T *drv;
identifier mutex, item_1, item_2, item_3;
@@

pthread_mutex_protects_3(&drv->mutex, drv->item_1, drv->item_2, drv->item_3);

@ find_pthread_fn depends on find_hint @
identifier fn, ret;
expression thread, attr, val;
@@

ret = pthread_create(thread, attr, fn, val);

@ check_fn_access @
identifier find_pthread_fn.fn;
type find_hint.T;
T *drv;
identifier find_hint.item_1;
identifier find_hint.item_2;
identifier find_hint.item_3;
@@

fn (...)
{
	<+...
(
	drv->item_1
|
	drv->item_2
|
	drv->item_3
)
        ...+>
}

@ check_helpers depends on find_pthread_fn @
identifier helper;
identifier find_pthread_fn.fn;
identifier find_hint.mutex;
type find_hint.T;
T *drv;
@@

fn (...)
{
	<+... when != pthread_mutex_lock(&drv->mutex);
	helper(...);
	...+>
}

@ helper_accessing_with_lock exists @
identifier check_helpers.helper;
type find_hint.T;
T *drv;
identifier find_hint.mutex;
identifier find_hint.item_1;
identifier find_hint.item_2;
identifier find_hint.item_3;
position p1, p2;
@@

helper(...)
{
	...
	pthread_mutex_lock at p1(&drv->mutex);
	<+...
(
	drv->item_1
|
	drv->item_2
|
	drv->item_3
)
        ...+>
	pthread_mutex_unlock at p2(&drv->mutex);
}

@ helper_accessing_without_lock exists @
identifier check_helpers.helper;
type find_hint.T;
T *drv;
identifier find_hint.mutex;
identifier find_hint.item_1;
identifier find_hint.item_2;
identifier find_hint.item_3;
@@

helper(...)
{
	<+... when != pthread_mutex_lock(&drv->mutex);
(
	drv->item_1
|
	drv->item_2
|
	drv->item_3
)
        ...+>
}

@ remove_helper_lock @
identifier check_helpers.helper;
type find_hint.T;
T *drv;
identifier find_hint.mutex;
identifier find_hint.item_1;
identifier find_hint.item_2;
identifier find_hint.item_3;
position helper_accessing_with_lock.p1, helper_accessing_with_lock.p2;
@@

helper(...)
{
	...
-	pthread_mutex_lock at p1(&drv->mutex);
	...
-	pthread_mutex_unlock at p2(&drv->mutex);
}


@ fix_top_level @
identifier find_pthread_fn.fn;
identifier find_hint.mutex;
identifier find_drv_name.drv;
@@

fn (...)
{
+	pthread_mutex_lock(&drv->mutex);
	...
+	pthread_mutex_unlock(&drv->mutex);
}
