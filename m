From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Dec 2014 04:05:20 +0100 (CET)
Subject: [Cocci] Initialization thrown away
In-Reply-To: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
References: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1412110404500.3123@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 10 Dec 2014, Ian Ohara wrote:

> Hi,
>
> Is it expected behaviour that:
>
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
>
> I've attached two files containing the source and .cocci file to duplicate
> this.? Also:
>
> $ spatch --version
> spatch version 1.0.0-rc22 with Python support and with PCRE support
>
> Thanks and let me know if there's more I can do to help,

It should not have matched at all.  I will check.

julia


> -Ian
>
>
