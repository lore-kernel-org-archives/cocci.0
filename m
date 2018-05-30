From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 30 May 2018 15:32:12 +0200
Subject: [Cocci] Increase precision for display of SmPL script execution
	durations
Message-ID: <b36b5d25-1784-6228-a689-0dbf8d15ffb0@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

The Coccinelle software can display profiling results for the execution
of SmPL scripts. The measured durations are formatted in a way so that
the information ?0.000 sec? is presented for some functions so far.
I guess that these data processing efforts were performed with a non-zero
time value.
How do you think about to show this detail precisely?

Regards,
Markus
