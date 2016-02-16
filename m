From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 16 Feb 2016 21:02:17 +0100
Subject: [Cocci] coccinelle: also catch kzfree() issues
In-Reply-To: <alpine.DEB.2.10.1602161815190.2685@hadrien>
References: <cover.1455638829.git.ydroneaud@opteya.com>
 <326298cef17f5109dc7b08094901aa1c69be83d5.1455638829.git.ydroneaud@opteya.com>
 <alpine.DEB.2.10.1602161815190.2685@hadrien>
Message-ID: <56C38049.7090205@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>  @free@
>> +identifier kfree =~ "kz?free";
> 
> Thanks for the suggestions.  However, the regular expression is not such a
> good idea.

How much is such a SmPL constraint still usable then?


> Coccinelle doesn't make any optimizations based on regulat expressions.

Where can your software optimise the source code search?


> It would be better to put a disjunction with kfree and kzfree explicitly,
> as in the other cases.

What are the circumstances for corresponding benefits?

Regards,
Markus
