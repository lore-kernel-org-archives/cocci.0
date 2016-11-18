From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 18 Nov 2016 19:00:04 +0100
Subject: [Cocci] Inclusion of script constraints in SmPL
In-Reply-To: <alpine.DEB.2.10.1611181842240.2963@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
 <alpine.DEB.2.10.1611161514250.3153@hadrien>
 <b90e8f82-aa00-0a11-1e38-53d8c4dfd9fd@users.sourceforge.net>
 <alpine.DEB.2.10.1611181842240.2963@hadrien>
Message-ID: <5da250c3-e80f-8842-7e85-481cdf6a6259@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> * Would such an inclusion approach trigger special requirements on the
>>   position for corresponding initialisation code?
> 
> The constraint specification should be a single function call.

Does the script constraint syntax allow more programming language code there?


> You can set up your @initialize:python@ code to import whatever you want.

I would prefer to keep initialisation code for the implementation of the
predicate function closely together with the call of the included metavariable.

Regards,
Markus
