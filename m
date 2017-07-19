From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Wed, 19 Jul 2017 10:54:54 +0000
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <CAGXu5jJgHumugb7F8GdDy911j7XvHNL9yW+tGsfkBHnR5-dTRA@mail.gmail.com>
References: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
 <1500364111-2192-2-git-send-email-elena.reshetova@intel.com>
 <CAGXu5jJgHumugb7F8GdDy911j7XvHNL9yW+tGsfkBHnR5-dTRA@mail.gmail.com>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF27362@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

 On Tue, Jul 18, 2017 at 12:48 AM, Elena Reshetova
> <elena.reshetova@intel.com> wrote:
> > atomic_as_refcounter.cocci script allows detecting
> > cases when refcount_t type and API should be used
> > instead of atomic_t.
> >
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > ---
> >  scripts/coccinelle/api/atomic_as_refcounter.cocci | 102
> ++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
> >
> > diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci
> b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > new file mode 100644
> > index 0000000..a16d395
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > @@ -0,0 +1,102 @@
> > +// Check if refcount_t type and API should be used
> > +// instead of atomic_t type when dealing with refcounters
> > +//
> > +// Copyright (c) 2016-2017, Elena Reshetova, Intel Corporation
> > +//
> > +// Confidence: Moderate
> > +// URL: http://coccinelle.lip6.fr/
> > +// Options: --include-headers --very-quiet
> > +
> > +virtual report
> > +
> > + at r1 exists@
> > +identifier a, x, y;
> > +position p1, p2;
> > +identifier fname =~ ".*free.*";
> > +identifier fname2 =~ ".*destroy.*";
> > +identifier fname3 =~ ".*del.*";
> > +identifier fname4 =~ ".*queue_work.*";
> > +identifier fname5 =~ ".*schedule_work.*";
> > +identifier fname6 =~ ".*call_rcu.*";
> > +
> > +@@
> > +
> > +(
> > + atomic_dec_and_test at p1(&(a)->x)
> > [...]
> > +)
> > +...
> > +?y=a
> > +...
> > +(
> > + fname at p2(a, ...);
> > +|
> > + fname at p2(y, ...);
> > +|
> > [...]
> 
> Just to double check, this "?y=a" catches the seccomp case I pointed out?
> 
>         while (orig && atomic_dec_and_test(&orig->usage)) {
>                 struct seccomp_filter *freeme = orig;
>                 orig = orig->prev;
>                 seccomp_filter_free(freeme);
>         }
> 

Yes, it does find the seccomp case, I was specifically testing this new addition on it. 


> Seems like it should match. Did this find anything else besides seccomp?

Yes, it found about 20 new things, but I haven't had a chance to look at them all yet.
In any case, I would really love to merge the existing conversions first (we still have about 80 patches left)
and only after add more of them. I looked at some new found cases and for example this was one:

./crypto/cryptd.c:474:38-57: atomic_dec_and_test variation before object free at line 475.

static void cryptd_skcipher_complete(struct skcipher_request *req, int err)
{
    struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
    struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
    struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
    int refcnt = atomic_read(&ctx->refcnt);

    local_bh_disable();
    rctx->complete(&req->base, err);
    local_bh_enable();

    if (err != -EINPROGRESS && refcnt && atomic_dec_and_test(&ctx->refcnt))
        crypto_free_skcipher(tfm);
}

While it isn't exactly the case I had in mind when trying to modify the pattern to work
for seccomp case, it came as a nice bonus IMO since we do want to catch these cases as well.
Overall it seems that pointers/structures can be so nicely wrapped around in some cases,
that keeping the pattern as generic as possible is a good way to go. Otherwise we might
start losing cases ( I would prefer a bit more false positives in this case instead as soon as
they are fine to manage). 

Best Regards,
Elena.

> 
> -Kees
> 
> --
> Kees Cook
> Pixel Security
