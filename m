From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 28 Aug 2013 15:38:26 +0200 (CEST)
Subject: [Cocci] problem with the order of added statements
In-Reply-To: <1377695972.3192.26.camel@zamolxis.metaware.tm.fr>
References: <1377695972.3192.26.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1308281536560.2279@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> PS. I sort of turned around the problem by splitting my rule in two:
>
> --- trace2.cocci:
> @@ statement s1; @@
>  if(...)
> +{trace("ifth");
>   s1
> +}
>
> @@ statement s1; @@
>  if(...) s1
> +trace("endif");

I was going to suggest this solution.  The empty block, though seems
strange.  I will look into it.

julia

> In this case, the third trace("endif") is correctly added after the
> "if", but the produced code is still a bit strange, as it contains an
> emtpy block:
>
>   if ( pcDate == 0 ) { trace("ifth");
>   {
> }
>     sRetour = 1;
>     return sRetour;
>   }
>   trace("endif");
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
