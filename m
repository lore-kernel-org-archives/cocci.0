From: rv@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Thu, 11 Sep 2014 09:16:50 +0200
Subject: [Cocci] Problem with "already tagged token"
References: <87fvfztqzq.fsf@rasmusvillemoes.dk>
 <alpine.DEB.2.10.1409101808470.4747@hadrien>
Message-ID: <87d2b2fwyl.fsf@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Sep 10 2014, Julia Lawall <julia.lawall@lip6.fr> wrote:

> Clever :)
>
> I haven't tried this, but I think you cudl do the following:
>
> @r@
> position p;
> @@
>
> seq_puts(...);
> seq_puts(...);
> seq_puts at p(...);
>
>> @concat1 depends on patch@
>> expression s;
>> constant c1, c2;
>> position p1, p2;
>
> Now change this line to
>
> position p1 != r.p, p2 != r.p;
>
> Then you can either use Coccinelle to do the iteration, or just run the
> semantic patch over and over on the code.
>

Thanks, that seems to work. Can you tell me how I would get coccinelle
to do the iteration? It's not really that important, since the
whitespace has to be fixed manually anyway, and with your suggestion one
finds all places with at least two consecutive seq_puts calls. But it
would be nice if one would _only_ have to fix whitespace

Thanks,
Rasmus
