From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 04 Mar 2015 14:13:31 +0100
Subject: [Cocci] Skipping of source code between preprocessor statements?
In-Reply-To: <alpine.DEB.2.10.1503040708010.3976@hadrien>
References: <F3E7ABF7-5E64-4AEF-B9CF-AE8CA0CE458B@allegro.com>
 <alpine.DEB.2.10.1503021753060.2763@hadrien>
 <54F6F112.4010004@users.sourceforge.net>
 <alpine.DEB.2.10.1503040708010.3976@hadrien>
Message-ID: <54F704FB.8020305@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> In which contexts does the syntax allow the use of single quotes
>> for the C programming language?
> 
> As far as I can tell, all.

Are they only valid within comments and string literals?


>> How would you like to handle text within the construct "#if 0 / #endif"
>> by the analysis tool?
> 
> There is a flag for choosing whether to do this.

Do you refer to the undocumented command line parameter "noif0-passing"?

Regards,
Markus
