From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Dec 2014 07:37:43 +0100 (CET)
Subject: [Cocci] Initialization thrown away
In-Reply-To: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
References: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1412110735400.2667@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> identifier i;
> @@
> -int i;
> +long i;
>
> Applied to a file containing:
>
> int a=20;
>
> Results in:
>
> diff =
> --- initializer_ignored.c
> +++ /tmp/cocci-output-19589-137add-initializer_ignored.c
> @@ -1 +1 @@
> -int a=20;
> +long a;
>
> I was expecting the =20; to be preserved, or at least that it just doesn't
> match unless I specify a separate case where I explicitly declare a constant
> metavariable and check for the case where the variable is initialized with a
> constant.

This is not at all the intended behavior.  It may be relted to recent
changes allowing the above to match things like int a, b, c;

As a temporary workaround, it seems that if one rewrites the
transformation as follows, then it has the desirable behavior of keeping
the = 20:

- int a
+ long a
  ;

julia
