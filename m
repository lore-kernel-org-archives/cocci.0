From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 17:02:40 +0100 (CET)
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <20131102155224.GX15704@leaf>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021455070.2261@hadrien> <20131102145412.GT15704@leaf>
 <alpine.DEB.2.02.1311021555360.2261@hadrien> <20131102155224.GX15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021656300.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > @r exists@
> > identifier f;
> > position p;
> > @@
> >
> > f(...) {
> >   ...
> >   RETURN at p;
> > }
> >
> > @@
> > position r.p;
> > @@
> >
> > - RETURN at p;
> >
> > @@
> > @@
> >
> > - RETURN;
> > + return;
>
> Cute.  I'm not sure why you need the two separate rules with matching
> positions; consolidating the two middle rules into one seems to work as
> well.  I did have to add a rule for when the return immediately followed
> a label, to make sure there was a statement to target.

I was worried that putting the rules together would cause an already
tagged token error, when there are several paths to the return, via gotos.

> However, this seems to have two issues.  First, to some extent I
> *wanted* the control-flow matching, to handle cases like this without
> having to do so explicitly:
>
> void f(void)
> {
> 	if (...) {
> 		foo();
> -		return;
> 	}
> }

This return is clearly not just before the ending brace...
You could have a separate rule for this case, but then there is still the
case where there are two nested ifs, etc.

> Second, this seems to lead to many formatting issues:
>
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -895,7 +895,7 @@ static void print_other_cpu_stall(struct
>
>  	rcu_print_detail_task_stall(rsp);
>
> -	force_quiescent_state(rsp);  /* Kick them all. */
> +	force_quiescent_state(rsp);
>  }
>
>  static void print_cpu_stall(struct rcu_state *rsp)
>
> No idea why coccinelle touched this comment.  Do functions have an
> implicit "return;" at the end that got patched here?

Yes, functions have an implicit return.  I was hoping that it wouldn't get
matched if the return was not written inside braces, but that doesn't seem
to have been successful...

> --- a/lib/xz/xz_crc32.c
> +++ b/lib/xz/xz_crc32.c
> @@ -43,7 +43,7 @@ XZ_EXTERN void xz_crc32_init(void)
>  		xz_crc32_table[i] = r;
>  	}
>
> -	return;
> +	RETURN;
>  }
>
>  XZ_EXTERN uint32_t xz_crc32(const uint8_t *buf, size_t size, uint32_t crc)
>
> No idea what happened here to prevent the RETURN; from getting
> substituted back.

Maybe a parsing problem?  I will look into it.

> Also, I noticed some cases where the return; in question immediately
> followed a label, so removing it would give that label no statement to
> jump to.  I tried handling that explicitly:
>
> @r1 depends on patch exists@
> identifier f, l;
> statement S;
> position p;
> @@
> void f(...)
> {
> ...
> (
> l:
> - RETURN;@p
>   S
> |
> l:
> - RETURN at p
>   ;
> |
> - RETURN;@p
> )
> }
>
> However, while this did produce the desired result when the return
> immeidately followed the label, it produced odd results in other cases:
>
> --- a/crypto/seqiv.c
> +++ b/crypto/seqiv.c
> @@ -45,6 +45,7 @@ static void seqiv_complete2(struct skcip
>
>  out:
>  	kfree(subreq->info);
> +	return;
>  }
>
>  static void seqiv_complete(struct crypto_async_request *base, int err)
>
> Many instances like this where coccinelle added "return;" where none
> existed before.

I don't think this has to do with the label issue, but with the implicit
return issue.

julia
