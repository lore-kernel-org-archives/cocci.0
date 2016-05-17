From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 May 2016 16:33:58 +0200 (CEST)
Subject: [Cocci] [PATCH] coccicheck: Fix missing 0 index in kill loop
In-Reply-To: <573B2B89.7060004@imag.fr>
References: <20160516125558.GA352@www.outflux.net> <573B2B89.7060004@imag.fr>
Message-ID: <alpine.DEB.2.10.1605171633460.3068@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 17 May 2016, Nicolas Palix (LIG) wrote:

> Le 16/05/16 14:55, Kees Cook a ?crit :
> > By default, "seq" counts from 1, but processes were starting counting
> > from 0, so when interrupted, coccicheck would leave the 0th process
> > running.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Nicolas Palix <nicolas.palix@imag.fr>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

>
>
> > ---
> >  scripts/coccicheck | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > index b2d758188f2f..dd85a455b2ba 100755
> > --- a/scripts/coccicheck
> > +++ b/scripts/coccicheck
> > @@ -98,7 +98,7 @@ run_cmd() {
> >  }
> >
> >  kill_running() {
> > -	for i in $(seq $(( NPROC - 1 )) ); do
> > +	for i in $(seq 0 $(( NPROC - 1 )) ); do
> >  		if [ $VERBOSE -eq 2 ] ; then
> >  			echo "Killing ${SPATCH_PID[$i]}"
> >  		fi
> >
>
>
> --
> Nicolas Palix
> http://lig-membres.imag.fr/palix/
>
>
