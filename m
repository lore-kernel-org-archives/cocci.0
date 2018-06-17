From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jun 2018 20:40:33 +0200 (CEST)
Subject: [Cocci] Searching for constants between shift operators with
 SmPL
In-Reply-To: <ae26a5be-ba96-cf08-c3cb-cced3c04f44d@users.sourceforge.net>
References: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
 <alpine.DEB.2.20.1806171949590.2506@hadrien>
 <ae26a5be-ba96-cf08-c3cb-cced3c04f44d@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806172038050.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Jun 2018, SF Markus Elfring wrote:

> > You can't just put ... at random places.
>
> I hope that this software aspect can be adjusted somehow.

No.

>
> > If you are in an expression, ... must replace a single expression.
>
> Can it be optional at the end?

I don't know what "it" refers to, but the answer is surely no.

>
> >> 2. I have observed that no source code is found if I omit the metavariables ?T?
> >>    and ?X? (omission of the assignment target) in a SmPL script variant.
> >
> > Since I don't know anythign about the code you are applying it to,
>
> Please look once more at the constructed example.
>
> int main(void)
> {
> unsigned int a = 2, b = 4;
> unsigned long c = a << 2 << b;
> }
>
>
> > and I don't know the exact definition of the semantic patch,
>
> Can the following SmPL search approach trigger further software development considerations?
>
> @display@
> constant C;
> expression A, B;
> @@
>  A
>  <<
> *C
>  <<
>  B ...;
>
>
> This SmPL script variant does not present the error message ?minus:
> parse error?.

That's true.  You have an expression followed by ... followed by an empty
statement.  It will match things like:

foo = x << 12 << b;
test();
test();
;

It doesn't match your sample program.

julia
