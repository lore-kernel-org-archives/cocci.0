From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 30 Mar 2014 14:44:34 +0200
Subject: [Cocci] Improvements for source code analysis with inclusion of
 header files
In-Reply-To: <alpine.DEB.2.10.1403301434580.2092@hadrien>
References: <5338004F.3090303@users.sourceforge.net>
 <alpine.DEB.2.10.1403301354280.2092@hadrien>
 <53380A7D.9060005@users.sourceforge.net>
 <alpine.DEB.2.10.1403301425110.2092@hadrien>
 <53380F07.9020500@users.sourceforge.net>
 <alpine.DEB.2.10.1403301434580.2092@hadrien>
Message-ID: <533811B2.4020109@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> 1. Which "C files" are referenced here?
> 
> The ones Coccinelle was asked to work on.

Do you distinguish headers from source files in this use case?


>> 2. File formats for the cache
> 
> Doesn't matter to the user.

I guess that such information will become more interesting for other software
developers, won't it?


>> 3. Explanation for abstract syntax trees in this context
> 
> Likewise.
> 
> The cache is something that Coccinelle writes into and reads out of.  Only
> Coccinelle cares what that format is.

I would appreciate if more details could be eventually documented in an other
format than the original OCaml source code.

Regards,
Markus
