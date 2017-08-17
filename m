From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Aug 2017 18:00:23 +0200 (CEST)
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <a0bda451-ef87-2317-2abc-62b1bd59e386@users.sourceforge.net>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
 <alpine.DEB.2.20.1708171721280.3748@hadrien>
 <a0bda451-ef87-2317-2abc-62b1bd59e386@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708171759271.3748@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 17 Aug 2017, SF Markus Elfring wrote:

> > ... when any should be ...>
>
> I am unsure if I interpret your suggestion correctly.

No.  Go read the original message again. It says exactly what to do and
where it should be done.  Eg, my message has two comments, but you have
made three changes, which is not correct.

julia

>
>
> @replacement@
> identifier action, var, work;
> type T, X;
> @@
>  T work(...)
>  {
>  <... ... when any ...>
>  X* var;
>  <... ... when any ...>
>  var = action(...,
>               sizeof(
> -                    X
> +                    *var
>                     ),
>               ...
>              )
>  <... ... when any ...>
>  }
>
>
> elfring at Sonne:~/Projekte/Linux/next-patched> git checkout next-20170803 && spatch.opt ~/Projekte/Coccinelle/janitor/safer_size_determination2.cocci fs/pstore/ram.c
> ?
> minus: parse error:
>   File "/home/elfring/Projekte/Coccinelle/janitor/safer_size_determination2.cocci", line 7, column 6, charpos = 80
>   around = '...',
>   whole content =  <... ... when any ...>
>
>
>
> > You request that the sizeof appear on every execution path.
>
> I hope not. - I would like to express that this operator can appear for
> a parameter of a function call.
>
> Does the variable declaration ?struct persistent_ram_zone *tmp_prz, *prz_next;?
> in the function ?ramoops_pstore_read? trigger challenges for the attempted
> source code transformation?
>
> Regards,
> Markus
>
