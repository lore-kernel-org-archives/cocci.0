From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 19:10:12 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612162004510.3178@hadrien>
References: <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
 <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
 <alpine.DEB.2.10.1612161531110.6500@hadrien>
 <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
 <alpine.DEB.2.10.1612161549220.6500@hadrien>
 <20161216170814.netw7heh2bdyvmm5@fbsd-laptop>
 <alpine.DEB.2.10.1612161929450.3239@hadrien>
 <20161216183705.madw4mpsfqmkvmky@fbsd-laptop>
 <alpine.DEB.2.10.1612162004510.3178@hadrien>
Message-ID: <20161216191011.cgxsa7mymssrjtsx@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 08:05:35PM +0100, Julia Lawall wrote:
> 
> 
> On Fri, 16 Dec 2016, Thomas Adam wrote:
> 
> > On Fri, Dec 16, 2016 at 07:30:46PM +0100, Julia Lawall wrote:
> > > The file I got had only pkg_vset, with some comments and includes
> > > beforehand.  Perhaps you sent the wrong one.
> >
> > Sorry, I meant pkg_vset() -- there's too many moving parts!  I'm sending the
> > entire .c file so that you might better place it in context with the debug
> > file I attached in my previous email.  Needless to say, despite my
> > chopping/changing this file, it's still not working.
> 
> For me they are all transformed.  What is your version of spatch?  What is
> your command line?  What is your semantic patch (you sent it before, but I
> no longer have it)?

% spatch --version
spatch version 1.0.4 with Python support and with PCRE support

See 'unchecked_malloc.cocci' attached.

I'm invoking spatch like this:

spatch --in-place --sp-file ~/unchecked_malloc.cocci libpkg/pkg.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: libpkg/pkg.c
Note: processing took    16.3s: libpkg/pkg.c

libpkg/pkg.c contains no transformations.

This is running atop of FreeBSD, should that somehow make any difference.

Thanks again!

Thomas
-------------- next part --------------
@@
expression T;
@@

T = malloc(...);
+ if (T == NULL)
+ 	pkg_emit_errno("malloc", __func__);
... when != (T == NULL)
    when != (T != NULL)

@@
expression T;
@@

T = calloc(...);
+ if (T == NULL)
+ 	pkg_emit_errno("calloc", __func__);
... when != (T == NULL)
    when != (T != NULL)

@@
expression T;
@@

T = realloc(...);
+ if (T == NULL)
+ 	pkg_emit_errno("realloc", __func__);
... when != (T == NULL)
    when != (T != NULL)

@@
expression T;
@@

T = strdup(...);
+ if (T == NULL)
+ 	pkg_emit_errno("strdup", __func__);
... when != (T == NULL)
    when != (T != NULL)
