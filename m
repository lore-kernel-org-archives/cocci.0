From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 13:01:28 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>	<554DB33D.2000000@users.sourceforge.net>
 <CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>
Message-ID: <554DE908.5060009@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> i want that my script detects only the dereference of a pointer
> when it is not checked different from NULL.

Does your goal belong to the usual software development challenges around
proper handling of return values?
https://cwe.mitre.org/data/definitions/252.html


> i want that my script detects only the dereference of a pointer
> and not the declaration ( exemple : int *k ;)  or the cast ( exemple : int *k ;)

I can understand that.


> or the initialisation ( (int) *s = &1;)

I would check also such source code places.


> @r@
> position p1 != {safe1.p,safe2.p};

Is such a SmPL constraint really needed?


> expression x;
> identifier y;
> @@
> 
> *x at p1->y

Which meaning should the asterisk get here?
- SmPL marker
- pointer dereference


Regards,
Markus
