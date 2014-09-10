From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Sep 2014 18:11:38 +0200 (CEST)
Subject: [Cocci] Problem with "already tagged token"
In-Reply-To: <87fvfztqzq.fsf@rasmusvillemoes.dk>
References: <87fvfztqzq.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1409101808470.4747@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Clever :)

I haven't tried this, but I think you cudl do the following:

@r@
position p;
@@

seq_puts(...);
seq_puts(...);
seq_puts at p(...);

> @concat1 depends on patch@
> expression s;
> constant c1, c2;
> position p1, p2;

Now change this line to

position p1 != r.p, p2 != r.p;

Then you can either use Coccinelle to do the iteration, or just run the
semantic patch over and over on the code.

julia

> @@
>   seq_puts at p1(s, c1);
>   seq_puts at p2(s, c2);
>
> @script:python concat2@
> c1 << concat1.c1;
> c2 << concat1.c2;
> c3;
> @@
>
> // The indentation probably needs to be fixed manually
> coccinelle.c3 = c1 + "\n\t" + c2
>
> @concat3 depends on patch@
> identifier concat2.c3;
> expression concat1.s;
> constant concat1.c1, concat1.c2;
> position concat1.p1, concat1.p2;
> @@
> - seq_puts at p1(s, c1);
> - seq_puts at p2(s, c2);
> + seq_puts(s, c3);
>
>
>
> Thanks,
> Rasmus
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
