From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Aug 2017 17:22:50 +0200 (CEST)
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708171721280.3748@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 17 Aug 2017, SF Markus Elfring wrote:

> Hello,
>
> I have constructed the following small script for another application of the
> semantic patch language.
>
>
> @replacement@
> identifier action, var, work;
> type T, X;
> @@
>  T work(...)
>  {
>  ... when any
>  X* var;
>  ... when any

... when any should be <...

>  var = action(...,
>               sizeof(
> -                    X
> +                    *var
>                     ),
>               ...
>              )
>  ... when any

... when any should be ...>

You request that the sizeof appear on every execution path.  <... ...>
will cause the transformation to be performed wherever appropriate, but
allow it not to be relevant on some execution paths.

julia

>  }
>
>
> I know that this transformation approach is working to some degree.
> I came along another source file where I do not get the desired code adjustment
> with the software version ?1.0.6-00186-g0acd38ee? automatically.
>
> elfring at Sonne:~/Projekte/Linux/next-patched> git checkout next-20170803 && spatch.opt ~/Projekte/Coccinelle/janitor/safer_size_determination1.cocci fs/pstore/ram.c
>
>
> How should the software situation be changed further so that the function
> ?ramoops_pstore_read? will be also handled in the way like I published it in the update suggestion ?pstore: Improve a size determination in three functions??
> http://elixir.free-electrons.com/linux/v4.12.8/source/fs/pstore/ram.c#L291
> https://patchwork.kernel.org/patch/9904523/
> https://lkml.kernel.org/r/<23798ef4-5559-3454-ecf4-e6844b644ff3@users.sourceforge.net>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
