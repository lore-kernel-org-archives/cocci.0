From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 17 Aug 2014 19:39:12 +0200
Subject: [Cocci] Conversion of some pointer arithmetic to array indexing
 style
In-Reply-To: <1408292542.17489.11.camel@joe-AO725>
References: <1408219616.2683.101.camel@joe-AO725>	
 <1408222763.2683.107.camel@joe-AO725>	
 <alpine.DEB.2.10.1408170510420.2599@hadrien>	
 <1408280475.17489.4.camel@joe-AO725>	
 <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
Message-ID: <53F0E8C0.1080704@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't think so as any type or combination of
> arithmetic operations would then need to be specified
> by the spatch input script.

I imagine that it will be occasionally useful to be more specific in
such semantic patterns.

@pointer_arithmetic@
identifier var, member, add;
int num1, num2;
@@
- *(var->member + add / num1 + num2)
+ var->member[add / num1 + num2]


> I think a precedence specification capability like first
> pointer match followed by longest arithmetic match would
> perhaps be a better generic facility.
>

I find it also nice when a semantic pattern could be written in a very
generic way. But I see that there are some technical challenges so that
false positives can be excluded.

Regards,
Markus
