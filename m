From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 21 May 2018 18:50:47 +0200
Subject: [Cocci] Using data from a parameter list with SmPL
Message-ID: <80999588-9b47-ce85-7354-2588dcbb228a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

A specific function can be found also by a selection on its parameter list.
The semantic patch language provides a metavariable type for this purpose.

I would occasionally like to create another function variant then.
It should get a shorter parameter list with a few elements from the other list.
Is it possible to construct something based on the first and second list element
in a generic way?

Regards,
Markus
