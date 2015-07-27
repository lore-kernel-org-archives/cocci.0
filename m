From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 27 Jul 2015 18:02:46 +0200
Subject: [Cocci] Finding non-zero returning functions with SmPL
In-Reply-To: <alpine.DEB.2.10.1507271733380.2453@hadrien>
References: <55B64BE0.7050303@users.sourceforge.net>
 <alpine.DEB.2.10.1507271733380.2453@hadrien>
Message-ID: <55B65626.4040209@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> *return_type work(...)
>>  {
>>   <+...
>>   return ... when != 0
>>              when != NULL
> 
> You can't put when on a ... that represents a single expression.

Thanks for your quick clarification.

Would it make sense that the Coccinelle software will also support
this construct at such a script place directly?


> expression e != {0,NULL};

The use of this SmPL metavariable seems to work to some degree.

Regards,
Markus
