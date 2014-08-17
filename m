From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Aug 2014 12:48:57 -0500 (CDT)
Subject: [Cocci] Conversion of some pointer arithmetic to array indexing
 style
In-Reply-To: <53F0E8C0.1080704@users.sourceforge.net>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725> <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
 <53F0E8C0.1080704@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408171246340.2520@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 17 Aug 2014, SF Markus Elfring wrote:

> > I don't think so as any type or combination of
> > arithmetic operations would then need to be specified
> > by the spatch input script.
>
> I imagine that it will be occasionally useful to be more specific in
> such semantic patterns.
>
> @pointer_arithmetic@
> identifier var, member, add;
> int num1, num2;
> @@
> - *(var->member + add / num1 + num2)
> + var->member[add / num1 + num2]

I don't see the need to be specific about the division, but it is true
that the associativity of + is annoying: whatever it is, there are always
cases ehere it is not what you want,  You can match things like this with

*(var->member + ...)

but there is no way to pick up on an expression that matches the ..., so
you have tomake special cases.  ON the other hand, you could see what
special cases are needed for your software with the above pattern.

julia
