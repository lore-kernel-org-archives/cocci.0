From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 09:11:57 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>
Message-ID: <554DB33D.2000000@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am asking you if you can help me to implement a semantic patch

Yes, of course.


> which allows to print out a warning before any pointer access,

This is possible in principle.


> if the pointer value not tested different from NULL.

Will it be more useful to look only at the value sources?

Did you inspect any examples?
Where do you get difficulties in your evolving SmPL scripts?

Regards,
Markus
