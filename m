From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Aug 2018 12:41:05 +0200 (CEST)
Subject: [Cocci] [PATCH] docs: dev-tools: coccinelle: Update
	documentation
In-Reply-To: <20180813103614.7495-1-himanshujha199640@gmail.com>
References: <20180813103614.7495-1-himanshujha199640@gmail.com>
Message-ID: <alpine.DEB.2.20.1808131240310.21501@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 13 Aug 2018, Himanshu Jha wrote:

> * Fix install instruction by adding `./autogen` command
>   before `./configure`.
> * Add link to a more detailed installation instruction.
> * Add link to SmPL grammar documentation.
> * Add single space after ',' to slightly improve readability.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  Documentation/dev-tools/coccinelle.rst | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 94f41c290bfc..f8305cd55186 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -30,18 +30,29 @@ of many distributions, e.g. :
>   - NetBSD
>   - FreeBSD
>
> -You can get the latest version released from the Coccinelle homepage at
> +Some distribution packages are obsolete and it is recommended
> +to use the latest version released from the Coccinelle homepage at
>  http://coccinelle.lip6.fr/
>
> -Once you have it, run the following command::
> +Or Github at:

Or from Github at:


>
> -     	./configure
> +https://github.com/coccinelle/coccinelle
> +
> +Once you have it, run the following commands::
> +
> +        ./autogen
> +        ./configure
>          make
>
>  as a regular user, and install it with::
>
>          sudo make install
>
> +More detailed installation instruction to build from source can be

instruction -> instructions

julia

> +found at:
> +
> +https://github.com/coccinelle/coccinelle/blob/master/install.txt
> +
>  Supplemental documentation
>  ---------------------------
>
> @@ -51,6 +62,10 @@ https://bottest.wiki.kernel.org/coccicheck
>
>  The wiki documentation always refers to the linux-next version of the script.
>
> +For Semantic Patch Language(SmPL) grammar documentation refer to:
> +
> +http://coccinelle.lip6.fr/documentation.php
> +
>  Using Coccinelle on the Linux kernel
>  ------------------------------------
>
> @@ -223,7 +238,7 @@ Since coccicheck runs through make, it naturally runs from the kernel
>  proper dir, as such the second rule above would be implied for picking up a
>  .cocciconfig when using ``make coccicheck``.
>
> -``make coccicheck`` also supports using M= targets.If you do not supply
> +``make coccicheck`` also supports using M= targets. If you do not supply
>  any M= target, it is assumed you want to target the entire kernel.
>  The kernel coccicheck script has::
>
> --
> 2.17.1
>
>
