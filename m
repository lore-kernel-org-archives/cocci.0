From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Nov 2016 23:03:14 +0100
Subject: [Cocci] SmPL script construction with several initialisation
 parts
In-Reply-To: <alpine.DEB.2.20.1611152250050.2060@hadrien>
References: <4633253e-3d59-edef-5778-b6f235fb9340@users.sourceforge.net>
 <alpine.DEB.2.20.1611152250050.2060@hadrien>
Message-ID: <10be3d5f-35ff-2a0e-2e51-b4c96b8ca20c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Can such initialisation code be constructed by the specification of several
>> script parts there?
> 
> I don't understand the question.

I suggest to consider corresponding design consequences again.


> If the script language supports includes, then you can put includes in the script code.

I imagine that it will be occasionally nicer to avoid the indirect inclusion
of another file there.
When will it be more consistent to construct an initialisation script
by your host programming language?

Regards,
Markus
