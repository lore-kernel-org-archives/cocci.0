From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 22 Jul 2015 19:42:45 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55ACDC1C.1040005@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
Message-ID: <55AFD615.3070905@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Does the following SmPL script draft show another interesting application
> of the semantic patch language?

Dear Julia,

I have adjusted this approach a bit for the programming interface "udev".
https://github.com/systemd/systemd/blob/bbf35206735f97cf3fcda8d26982b35b0cad20a9/src/udev/udev.h#L68

It seems that the Coccinelle software needs remarkable execution times
for the analysis of specific source files from this library.
I am unsure again which timeout value will be appropriate here.

Do I become too impatient with my computer?

Regards,
Markus
