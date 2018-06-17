From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jun 2018 21:10:40 +0200 (CEST)
Subject: [Cocci] Searching for constants between shift operators with
 SmPL
In-Reply-To: <4179275b-eafb-7622-2f92-06a4b0b1b39e@users.sourceforge.net>
References: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
 <alpine.DEB.2.20.1806171949590.2506@hadrien>
 <ae26a5be-ba96-cf08-c3cb-cced3c04f44d@users.sourceforge.net>
 <alpine.DEB.2.20.1806172038050.2506@hadrien>
 <4179275b-eafb-7622-2f92-06a4b0b1b39e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806172108320.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The following file combination produces another usable search result.
>
> @display@
> constant C;
> expression A, B;
> identifier X;
> type T;
> @@
>  T X = A
>  <<
> *C
>  <<
>  B + ...;

Yes, because now ... is replacing an expression.

> Should anything be found in the following source code variant then?
>
> int main(void)
> {
> unsigned int a = 2, b = 4;
> unsigned long c = a << 2 << b;
> return c;
> }

No, because there is no empty statement to match the final ;.  The ...
matches a complete statement (in general, 0 or more complete statements).
It doesn't match return c

julia
