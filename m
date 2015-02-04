From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 13:38:14 +0100 (CET)
Subject: [Cocci] broken comments handling
In-Reply-To: <20150204083900.GA2093@rei.scz.novell.com>
References: <20150204083900.GA2093@rei.scz.novell.com>
Message-ID: <alpine.DEB.2.10.1502041337360.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 4 Feb 2015, Cyril Hrubis wrote:

> Hi!
> I've found potentialy harmful bug while using spatch, see below.
>
> bug.c:
> int a; /* This is comment for a */
> int b; /* This is comment for b */
>
> bug.cocci:
> @@ @@
> -int b;
>
> spatch-23 bug.cocci bug.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> warning: line 2: should b be a metavariable?
> HANDLING: bug.c
> diff =
> --- bug.c
> +++ /tmp/cocci-output-2227-08362d-bug.c
> @@ -1,2 +1 @@
> -int a; /* This is comment for a */
> -int b; /* This is comment for b */
> +int a; /* This is comment for b */
>
> The comment for a is removed and replaced with the comment for b, which may
> lead to serious confusion.

Thanks.

I would have expected that both comments would stay.  I will look into it.
Thanks for the report.

julia
