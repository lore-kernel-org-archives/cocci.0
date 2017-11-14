From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Nov 2017 17:55:46 +0100 (CET)
Subject: [Cocci] [PATCH v3] coccinelle: fix parallel build with
 CHECK=scripts/coccicheck
In-Reply-To: <20171114165221.GF729@wotan.suse.de>
References: <1510650290-3363-1-git-send-email-yamada.masahiro@socionext.com>
 <20171114165221.GF729@wotan.suse.de>
Message-ID: <alpine.DEB.2.20.1711141754420.2874@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Nov 2017, Luis R. Rodriguez wrote:

> On Tue, Nov 14, 2017 at 06:04:49PM +0900, Masahiro Yamada wrote:
> > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > index 040a8b1..7da82a1 100755
> > --- a/scripts/coccicheck
> > +++ b/scripts/coccicheck
> > @@ -70,6 +64,13 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
> >      # Take only the last argument, which is the C file to test
> >      shift $(( $# - 1 ))
> >      OPTIONS="$COCCIINCLUDE $1"
> > +
> > +    # If -j option is given to Make, scripts/coccicheck runs in parallel.
> > +    # If coccinelle also runs in parallel, it fails because multiple processes
> > +    # try to get access to the same subdirectory that stores stdout/stderr.
> > +    # No need to parallelize coccinelle in this case - this mode takes only
> > +    # one file input.
> > +    NPROC=1
>
> Shouldn't this also warn to the user, and recommend to use a proper form to
> parallelize coccinelle? Otherwise a user might get the impression they are
> parallelizing coccinelle where they really did not.

Coccinelle sees a file at a time when using C=1 or C=2.  There is nothing
to parallelize at the Coccinelle level, if you want to use these options.

julia


>
>   Luis
>
> >  else
> >      ONLINE=0
> >      if [ "$KBUILD_EXTMOD" = "" ] ; then
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
