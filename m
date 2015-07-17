From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 17 Jul 2015 13:12:37 +0200
Subject: [Cocci] Deletion of blank lines?
In-Reply-To: <alpine.DEB.2.10.1507171150150.2404@hadrien>
References: <55A60721.5050209@users.sourceforge.net>
 <55A743F3.6000500@users.sourceforge.net>
 <alpine.DEB.2.10.1507171150150.2404@hadrien>
Message-ID: <55A8E325.4030902@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Is there a blank line after the call to exit(1); also?

No.

The text line which follows the shown exit() call should only contain
the closing curly bracket for the sigterm_handler() function according to
the commit "Load cups into easysw/current."
(ef416fc25c4af449e930416117bedb12fc9924ba) from 2006-01-13.


> I think that it tries toavoid creeating two blank lines.

Should the blank line between the shown calls be usually preserved
by default?

When would the suggested functionality (like a bit of extra source code clean-up)
be really needed?

Regards,
Markus
