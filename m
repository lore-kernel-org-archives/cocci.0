From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 2 Feb 2016 13:23:28 +0100
Subject: [Cocci] Extending source code at file end with SmPL
In-Reply-To: <alpine.DEB.2.10.1602021237150.2494@hadrien>
References: <56B07D22.1060309@users.sourceforge.net>
 <alpine.DEB.2.10.1602021111510.2494@hadrien>
 <56B08B5D.3070301@users.sourceforge.net>
 <alpine.DEB.2.10.1602021205280.2494@hadrien>
 <56B09453.5080501@users.sourceforge.net>
 <alpine.DEB.2.10.1602021237150.2494@hadrien>
Message-ID: <56B09FC0.2090305@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I would also appreciate if the input file will be checked according to specific
>> source code search patterns.
> 
> I guess you can generate what you want with Coccinelle, and then cat it
> onto the end of some other file and do diff to get a patch.

I am looking for possibilities to keep a tool like "spatch" the central
interface for the specification of desired source code changes.
I would like to avoid the patch generation for special search patterns
by various workarounds.
How many software development efforts are needed then to keep corresponding
context information (like line numbers for patch hunks) consistent?

Regards,
Markus
