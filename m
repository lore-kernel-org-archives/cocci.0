From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jun 2018 19:51:24 +0200 (CEST)
Subject: [Cocci] Searching for constants between shift operators with
 SmPL
In-Reply-To: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
References: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806171949590.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Jun 2018, SF Markus Elfring wrote:

> Hello,
>
> The following script for the semantic patch language can mark a bit of source
> code also in a corresponding example.
>
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
>  B;
>
>
> int main(void)
> {
> unsigned int a = 2, b = 4;
> unsigned long c = a << 2 << b;
> }
>
>
> 1. I get the error message ?minus: parse error? after the addition of
>    a SmPL ellipsis behind the metavariable ?B?.

You can't just put ... at random places.  If you are in an expression, ...
must replace a single expression.

> 2. I have observed that no source code is found if I omit the metavariables ?T?
>    and ?X? (omission of the assignment target) in a SmPL script variant.

Since I don't know anythign about the code you are applying it to, and I
don't know the exact definition of the semantic patch, I can't answer the
question.

julia

>
> How do you think about to clarify these software situations any more?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
