From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 26 Feb 2014 08:25:35 +0100
Subject: [Cocci] Branch layout for if statements with SmPL disjunctions
In-Reply-To: <alpine.DEB.2.10.1402251014170.2080@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
Message-ID: <530D96EF.7050306@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> ( if (input) is
>> | if (likely(input)) is
>> )
>>   else es
> 
> This is not allowed.  Inside a disjunction you need to have complete terms.

I imagine that it would be nice if parts from an if statement could be written
in the shown way. Would such an extension be useful for the semantic patch language?

I can easily adjust my simple pattern here because each if branch will be
matched by a metavariable. I hope that the corresponding repetition of bigger
subpatterns can be avoided in the future.

Regards,
Markus
