From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Aug 2018 11:28:07 +0200 (CEST)
Subject: [Cocci] Adjustment for const qualification
In-Reply-To: <b417bf64-7970-8482-0246-ab00129b4657@users.sourceforge.net>
References: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
 <b417bf64-7970-8482-0246-ab00129b4657@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1808151127520.2309@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Aug 2018, SF Markus Elfring wrote:

> > https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0027-genl-const/genl-const.cocci
>
> How do you think about to try the following SmPL script variant out?
>
> @replacement@
> @@
> -const
> +__genl_const
>  struct
> (
>  genl_multicast_group
> |genl_ops
> )

This is rejected by the semantic patch parser.

julia
