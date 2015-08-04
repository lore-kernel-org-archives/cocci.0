From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 4 Aug 2015 19:09:16 +0200
Subject: [Cocci] Replacing function definition with a macro
In-Reply-To: <alpine.DEB.2.10.1508041029360.2327@hadrien>
References: <CANMuvJ=qX99uQAL4PL1jt8ExqthVq_BJO6q+GNoqzLSrHCxqqw@mail.gmail.com>
 <alpine.DEB.2.10.1508041029360.2327@hadrien>
Message-ID: <55C0F1BC.2040206@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Coccinelle expects that each element in a parameter list will have the
> form type identifier.

Is the Coccinelle software still limited to some degree for the handling
of function parameters?


> In the case of name, you just have an identifier.
> I don't really see a solution.

How do you think about direct support for macro parameter lists?
Does anybody dare to contribute corresponding software development efforts?

Are there any more limitations to reconsider so that further post-processing
can be avoided for generated patches?

Regards,
Markus
