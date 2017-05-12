From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 May 2017 20:15:55 +0800 (SGT)
Subject: [Cocci] howto conditional match
In-Reply-To: <3f759e1c-e081-910b-9012-a5d3e5902f48@broadcom.com>
References: <3f759e1c-e081-910b-9012-a5d3e5902f48@broadcom.com>
Message-ID: <alpine.DEB.2.20.1705122014540.3725@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 12 May 2017, Arend van Spriel wrote:

> I have the following rule in my cocci script. Actually, want to apply the
> patch conditionally, ie. when type S matches one or more structure
> definitions. Initially I had 'struct Foo *drvr, ...' but that did not work for
> me. Any hints are appreciated.
>
> Regards,
> Arend
>
> @@
> identifier func;
> identifier drvr;
> type T;
> expression list es;
> type S;
> @@
>         T func(S *drvr, ...)

struct i *drvr, where i is an identifier metavariable?  I'm not sure what
you mean by one or more. Do you want to match more than the first
argument?

julia


>         {
>                 <...
> -               brcmf_err(es);
> +               brcmf_derr(drvr, es);
>                 ...>
>         }
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
