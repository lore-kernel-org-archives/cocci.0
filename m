From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Apr 2018 13:32:18 +0200 (CEST)
Subject: [Cocci] please help me with a "repetition"
In-Reply-To: <kkefiy2s6f.fsf@bora.foobar.de>
References: <kkefiy2s6f.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1804291328170.4211@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 29 Apr 2018, Robert Larice wrote:

> Hello,
>
>   probably a stupid question,
>   I'm failing to match something like this
>
> +  int newvar;
>    i++; i++; ... any sequence of only "i++";
> +  buckbear(42);
>
>   I don't succeed to express this "maximum length repetition"
>     in the mids of those two insertions.

It's not completely straightforward.  You could try:

@r1@
position p;
@@

i++;
i++;@p

@@
position p != r1.p;
@@

+ int newvar;
i++;@p

@r2@
position p;
@@

i++;@p
i++;

@@
position p != r2.p;
@@

i++;@p
+ buckbear(42);

julia



>
> Best Regards,
>   Robert
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
