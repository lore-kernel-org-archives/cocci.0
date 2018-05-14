From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 14 May 2018 15:10:19 +0200
Subject: [Cocci] Moving a function body to an other source code place with
	SmPL
Message-ID: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am curious on how good the Coccinelle software can support a specific
source code transformation:
It would be occasionally nice if an implementation of a function could be
completely stored into a metavariable.
Is a statement list variable appropriate for this use case?

Can these data be moved to an other function (or macro definition)?

Regards,
Markus
