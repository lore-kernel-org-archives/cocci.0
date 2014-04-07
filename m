From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 07 Apr 2014 17:28:52 +0200
Subject: [Cocci] How to exclude volatile data accesses in expressions
	with SmPL?
In-Reply-To: <alpine.DEB.2.10.1404071715180.2187@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53342A9C.9070406@users.sourceforge.net>
 <alpine.DEB.2.10.1403271907390.2088@hadrien>
 <5334705A.9050303@users.sourceforge.net>
 <alpine.DEB.2.10.1403271942390.2088@hadrien>
 <5342BF46.8030405@users.sourceforge.net>
 <alpine.DEB.2.10.1404071715180.2187@hadrien>
Message-ID: <5342C434.6020805@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How do you think about to make it possible to check attributes for expressions
>> in SmPL constraints?
> 
> I tried to do this at one point, but it introduced a lot of parsing
> problems, because attributes can appear in a variety of places.

Which kind of syntax had you got in mind for such a functionality?

Is there a need to distinguish property checks from support for extensions from
a popular compiler implementation?
http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/Type-Attributes.html


> The benefit didn't seem to be worth the risk.

Can we clarify your concerns a bit more here?

Regards,
Markus
