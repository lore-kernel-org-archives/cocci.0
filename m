From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Feb 2017 13:06:37 +0100 (CET)
Subject: [Cocci] Replacing combination of kcalloc() and copy_from_user()
 by memdup_user() with SmPL?
In-Reply-To: <32e33451-c8ba-1a01-bc41-a6b8c6fc78bb@users.sourceforge.net>
References: <d5f46773-2137-d1d7-97d0-fb97721d4982@users.sourceforge.net>
 <32e33451-c8ba-1a01-bc41-a6b8c6fc78bb@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1702151303520.3116@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Feb 2017, SF Markus Elfring wrote:

> > elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt replace_kcalloc_by_memdup_user-draft1.cocci ../Probe/user_sdma-excerpt1.c
> > ?
> > refactoring: position variables or mixed modifs interfere with comm_assoc iso
> > bool (bool !to
> >   >>> IS_ERR(to)
> >  || ...)
> > ?
>
> Would you like to explain this message a bit more while the following SmPL approach seems to work
> as expected?

The comm_assoc isomorphism allows A || ... to match any disjunction where
A appears at the top level, not just in the far left position.  It also
matches the case where A is not present at all.

I don't know what the original semantic patch looks like, so I don't know
exactly what is preventing this isomorphism from applying.

julia


>
> @refactoring@
> expression code, count, from, to, size;
> identifier label, log;
> @@
>  to =
> -     kcalloc(count, size, GFP_KERNEL)
> +     memdup_user(from, size * count)
>  ;
>  if (
> -    !to
> +    IS_ERR(to)
>     ) {
> -   code = -ENOMEM;
> -   goto label;
> -}
> -code = copy_from_user(to, from, (size) * (count));
> -if (code) {
>     ...
> +   code = PTR_ERR(to);
>     log(..., code, ...);
> -   code = -EFAULT;
>     goto label;
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt replace_kcalloc_by_memdup_user-draft2.cocci ../Probe/user_sdma-excerpt1.c
> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
> HANDLING: ../Probe/user_sdma-excerpt1.c
> diff =
> --- ../Probe/user_sdma-excerpt1.c
> +++ /tmp/cocci-output-8749-f5da06-user_sdma-excerpt1.c
> @@ -11,20 +11,12 @@ int hfi1_user_sdma_process_request(struc
>  			ret = -EINVAL;
>  			goto free_req;
>  		}
> -		req->tids = kcalloc(ntids, sizeof(*req->tids), GFP_KERNEL);
> -		if (!req->tids) {
> -			ret = -ENOMEM;
> -			goto free_req;
> -		}
> -		/*
> -		 * ...
> -		 */
> -		ret = copy_from_user(req->tids, iovec[idx].iov_base,
> -				     ntids * sizeof(*req->tids));
> -		if (ret) {
> +		req->tids = memdup_user(iovec[idx].iov_base,
> +					sizeof(*req->tids) * ntids);
> +		if (IS_ERR(req->tids)) {
> +			ret = PTR_ERR(req->tids);
>  			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",
>  				 ntids, ret);
> -			ret = -EFAULT;
>  			goto free_req;
>  		}
>  		req->n_tids = ntids;
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
