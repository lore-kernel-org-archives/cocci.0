From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Nov 2016 14:12:09 +0100
Subject: [Cocci] Further developments around SmPL constraints?
In-Reply-To: <alpine.DEB.2.10.1611161350550.3153@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
Message-ID: <d803f075-79a2-85be-9bcd-4222162e05b9@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Can other SmPL rule types specify constraints in the code form of a
>> regular expression or a programming language script?
> At the moment, the specification of constraints is not very uniform across
> the different metavariable types.  We are working on improving this.

* Have you got any time frame in mind for this software evolution?
  How many people are involved already?

* Is this the reason that the functionality ?Script constraints on
meta-variables? is not explained in the SmPL manual so far?
 
https://github.com/coccinelle/coccinelle/blob/cbc751b30d9e02390d60ebed643c8e4a3fa0bb2b/tests/idcon_python.cocci#L1

Regards,
Markus
