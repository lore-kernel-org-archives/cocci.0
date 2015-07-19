From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Jul 2015 20:48:10 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.02.1507191820360.2077@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
 <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
 <55AB9E11.4080501@users.sourceforge.net>
 <alpine.DEB.2.02.1507191504310.2002@localhost6.localdomain6>
 <55ABB754.1000109@users.sourceforge.net>
 <alpine.DEB.2.02.1507191820360.2077@localhost6.localdomain6>
Message-ID: <55ABF0EA.5080705@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> typedef int mytype;
> 
> mytype x;
> 
> Clearly this would not be the same as
> 
> typedef int x;

I see a bit more here.

But my knowledge in the application of the semantic patch language
is still evolving also around such details. The corresponding distinction
is not clear enough for me so far.

Is the handling of "typedefs" another detail for later considerations?



>> I am still unfamiliar with the consequences from the use of 
>> variables like "v" and "x" when they are not position variables
>> as you suggest in your example script.
> 
> They match the closest enclosing expression.

I see that there are also a few other items mentioned in the manual.
Unfortunately, the description is terse.
https://github.com/coccinelle/coccinelle/blob/af8131522ee9aff575e4345f5068f4f138264cd6/docs/manual/cocci_syntax.tex#L258

But I am unsure about when this special SmPL construct will help
in the discussed use case.

Regards,
Markus
