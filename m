From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 14:32:15 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <CABBGRWv9UiJ0WBdPVC=Uj_osqgzhwoOrT3uTqFCzSjVe3T1QmA@mail.gmail.com>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>	<554DB33D.2000000@users.sourceforge.net>	<CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>	<554DE908.5060009@users.sourceforge.net>	<CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>	<554DF181.5070707@users.sourceforge.net>	<CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>	<554DF718.80209@users.sourceforge.net>
 <CABBGRWv9UiJ0WBdPVC=Uj_osqgzhwoOrT3uTqFCzSjVe3T1QmA@mail.gmail.com>
Message-ID: <554DFE4F.1050901@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> ?, i want that my scripts detects only the access to pointer
> and not its declaration, cast or initialization.

Will it be more useful to find the source code places
where a null pointer occurs (before an access try will happen)?

How do you think about more fine-tuning for your SmPL scripts?

Would you like to extend my previous approaches for
return value checking?

Regards,
Markus
