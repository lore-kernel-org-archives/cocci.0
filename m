From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 10 Jun 2018 08:39:07 +0200 (CEST)
Subject: [Cocci] High level restriction of function calls with SmPL
In-Reply-To: <8f24e468-34d5-7cce-9543-7833fc8e76f7@users.sourceforge.net>
References: <8f24e468-34d5-7cce-9543-7833fc8e76f7@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806100838190.2313@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 10 Jun 2018, SF Markus Elfring wrote:

> Hello,
>
> I would like to try another source code transformation out with the help of
> the semantic patch language.
> The following approach can express a bit of information I became interested in.
>
>  {
>  ... when any
>      when != action(..., input, ...)
>  }
>
>
> Now I am looking for ways to restrict (or filter) such function calls further.
> The passed parameter should correspond to a specific data type property.
> Can it be determined here together with a scripted constraint?

"restrict ... further" and "correspond" are not precise.  I have no idea
what you want to do.  Please provide and exmaple.

julia


>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
