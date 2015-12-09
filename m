From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Dec 2015 13:00:57 +0100
Subject: [Cocci] Finding labelled statements with SmPL
In-Reply-To: <alpine.DEB.2.10.1512091114520.2491@hadrien>
References: <5667F25B.1080901@users.sourceforge.net>
 <alpine.DEB.2.10.1512091114520.2491@hadrien>
Message-ID: <566817F9.9010800@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> A label has to be an identifier.

This wording fits only to a jump label for the statement "goto", doesn't it?


> A sequence of all capital letters is also an identifier.

Does this feedback mean that the following SmPL approach should also work
for case labels?


@label_used@
identifier label;
@@
*label:


How much do constant expressions matter in such a source code analysis?

Why did I get the message "minus: parse error"?

Regards,
Markus
