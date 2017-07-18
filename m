From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Jul 2017 09:21:07 -0700
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <1500364111-2192-2-git-send-email-elena.reshetova@intel.com>
References: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
 <1500364111-2192-2-git-send-email-elena.reshetova@intel.com>
Message-ID: <CAGXu5jJgHumugb7F8GdDy911j7XvHNL9yW+tGsfkBHnR5-dTRA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 18, 2017 at 12:48 AM, Elena Reshetova
<elena.reshetova@intel.com> wrote:
> atomic_as_refcounter.cocci script allows detecting
> cases when refcount_t type and API should be used
> instead of atomic_t.
>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 102 ++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
>
> diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> new file mode 100644
> index 0000000..a16d395
> --- /dev/null
> +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> @@ -0,0 +1,102 @@
> +// Check if refcount_t type and API should be used
> +// instead of atomic_t type when dealing with refcounters
> +//
> +// Copyright (c) 2016-2017, Elena Reshetova, Intel Corporation
> +//
> +// Confidence: Moderate
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --include-headers --very-quiet
> +
> +virtual report
> +
> + at r1 exists@
> +identifier a, x, y;
> +position p1, p2;
> +identifier fname =~ ".*free.*";
> +identifier fname2 =~ ".*destroy.*";
> +identifier fname3 =~ ".*del.*";
> +identifier fname4 =~ ".*queue_work.*";
> +identifier fname5 =~ ".*schedule_work.*";
> +identifier fname6 =~ ".*call_rcu.*";
> +
> +@@
> +
> +(
> + atomic_dec_and_test at p1(&(a)->x)
> [...]
> +)
> +...
> +?y=a
> +...
> +(
> + fname at p2(a, ...);
> +|
> + fname at p2(y, ...);
> +|
> [...]

Just to double check, this "?y=a" catches the seccomp case I pointed out?

        while (orig && atomic_dec_and_test(&orig->usage)) {
                struct seccomp_filter *freeme = orig;
                orig = orig->prev;
                seccomp_filter_free(freeme);
        }

Seems like it should match. Did this find anything else besides seccomp?

-Kees

-- 
Kees Cook
Pixel Security
