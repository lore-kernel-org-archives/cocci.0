From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Sat, 9 May 2015 14:39:16 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <554DFE4F.1050901@users.sourceforge.net>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>
 <554DB33D.2000000@users.sourceforge.net>
 <CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>
 <554DE908.5060009@users.sourceforge.net>
 <CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>
 <554DF181.5070707@users.sourceforge.net>
 <CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>
 <554DF718.80209@users.sourceforge.net>
 <CABBGRWv9UiJ0WBdPVC=Uj_osqgzhwoOrT3uTqFCzSjVe3T1QmA@mail.gmail.com>
 <554DFE4F.1050901@users.sourceforge.net>
Message-ID: <CABBGRWujpoCsnfpDRgjFtnNKaOakozVtLEKwgccD_vVuwFd6aA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thank you Julia,
Markus , i think that your previous approaches for
return value checking could be useful for me, where can i find the script?

2015-05-09 14:32 GMT+02:00 SF Markus Elfring <elfring@users.sourceforge.net>
:

> > ?, i want that my scripts detects only the access to pointer
> > and not its declaration, cast or initialization.
>
> Will it be more useful to find the source code places
> where a null pointer occurs (before an access try will happen)?
>
> How do you think about more fine-tuning for your SmPL scripts?
>
> Would you like to extend my previous approaches for
> return value checking?
>
> Regards,
> Markus
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150509/b6ab9682/attachment.html>
