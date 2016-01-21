From: wagi@monom.org (Daniel Wagner)
Date: Thu, 21 Jan 2016 10:47:54 +0100
Subject: [Cocci] Filter out field names
Message-ID: <56A0A94A.9070702@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am trying to transform Linux kernel code in order to test for data
races. Let me illustrate this by an example


struct lpctx {
	spinlock_t lock;
	int cnt;
};
static struct lpctx *lpctx;

static void lpctx_good1(struct lpctx *lx)
{
	spin_lock(&lx->lock);

	lx->cnt++;

	spin_unlock(&lx->lock);
}

static void lpctx_warning1(struct lpctx *lx)
{
	lx->cnt++;
}


As you can see lptctx_warning1() is increasing the counter without
holding the lock. The main idea(*) is to annotate all accesses to lx by
adding a WARN_ON(!lock_is_held(&lx->lock.dep_map)).

Thanks to Julia's excellent help on IRC I have currently this somewhat
working cocci script:


@depends on patch@
struct lpctx *x;
identifier f;
statement S;
@@

( S
+	WARN_ON(!lock_is_held(&x->lock.dep_map));
&
	x->f
)


This results in:

@@ -16,10 +16,13 @@ static void lpctx_good1(struct lpctx *lx
        DBG("");

        spin_lock(&lx->lock);
+       WARN_ON(!lock_is_held(&lx->lock.dep_map));

        lx->cnt++;
+       WARN_ON(!lock_is_held(&lx->lock.dep_map));

        spin_unlock(&lx->lock);
+       WARN_ON(!lock_is_held(&lx->lock.dep_map));
 }

 static void lpctx_warning1(struct lpctx *lx)
@@ -27,6 +30,7 @@ static void lpctx_warning1(struct lpctx
        DBG("");

        lx->cnt++;
+       WARN_ON(!lock_is_held(&lx->lock.dep_map));
 }


There are a bunch of problems, e,g. the hard coded type/names or the
WARN_ON() should be put in front of the deferences but that is something
for later to improve. The main problem I face at this point is to filter
out the spin_lock() and spin_unlock() access. All my attempts didn't let
to the expected result. I think the best thing would be to match on the
type. So if 'f' is of type spinlock_t ignore it. Any ideas how this
could be expressed?

Thanks,
Daniel


(*) Talking with Nicholas over a coffee helps a lot. Thanks a lot!
