From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 16 Feb 2016 21:22:49 +0100
Subject: [Cocci] coccinelle: also catch kzfree() issues
In-Reply-To: <alpine.DEB.2.10.1602161516450.6722@hadrien>
References: <cover.1455638829.git.ydroneaud@opteya.com>
 <326298cef17f5109dc7b08094901aa1c69be83d5.1455638829.git.ydroneaud@opteya.com>
 <alpine.DEB.2.10.1602161815190.2685@hadrien>
 <56C38049.7090205@users.sourceforge.net>
 <alpine.DEB.2.10.1602161516450.6722@hadrien>
Message-ID: <56C38519.8020103@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> Coccinelle doesn't make any optimizations based on regulat expressions.
>>
>> Where can your software optimise the source code search?
> 
> When the name appears explicitly in the matching code, Coccinelle will
> parse and process only files that contain that name.

Does your software perform any file filtering on a passed selection
under special circumstances?

Regards,
Markus
