From: joe@perches.com (Joe Perches)
Date: Thu, 08 Sep 2016 21:38:08 -0700
Subject: [Cocci] [PATCH] da905x: Add const to da905x_regulator_info
	blocks
In-Reply-To: <4732dc91a1990c04217370e5ecced704@newmail.lip6.fr>
References: <bc2a69f70af39247994fd2b26e36d1b254576247.1473389324.git.joe@perches.com>
 <1473389785.13672.25.camel@perches.com>
 <4732dc91a1990c04217370e5ecced704@newmail.lip6.fr>
Message-ID: <1473395888.13672.29.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2016-09-09 at 12:28 +0800, Julia Lawall wrote:
> Le 09.09.2016 10:56, Joe Perches a ?crit?:
> > Could coccinelle identify non-const arrays that are never modified
> > by anything and add const like this patch below by some mechanism?
> If you know the type that should be const, then Coccinlle can add the
> consts everywhere.

Sure, but the fundamental here is that you don't know that
the type _could_ be const.

> Coccinelle doesn't always have complete type information, because it
> doesn't necessarily have access to all header files, so it is not clear
> that it could be useful for it to blindly search for all structures that
> are used in a read-only way.

In the example given the struct definitions are file local.

It's not an easy problem but it could be worthwhile when all
structure members are never modified after initialization.
