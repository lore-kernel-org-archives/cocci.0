From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Sat, 9 May 2015 13:48:21 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <554DF181.5070707@users.sourceforge.net>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>
 <554DB33D.2000000@users.sourceforge.net>
 <CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>
 <554DE908.5060009@users.sourceforge.net>
 <CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>
 <554DF181.5070707@users.sourceforge.net>
Message-ID: <CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

this code was implemented just to test the script.
my SmPL script will be applied to a big embedded project. it must detect
all the dereferences of all the pointers when the pointer is not checked
different from NULL before access.

2015-05-09 13:37 GMT+02:00 SF Markus Elfring <elfring@users.sourceforge.net>
:

> > void main () {
> >     (int) *s = &1;
>
> I find the parentheses unnecessary for the data type specification.
>
>
> >     *s =2;
> >     p = malloc( sizeof (int)) ;
>
> Is a single integer allocated for demonstration here?
>
> Did you miss the data type specification for this variable?
>
>
> > concerning *x at p1->y
> >
> > it allows to detect the dereference of a pointer (x->y)
>
> I would expect that the asterisk should not be placed
> in the first text column of your SmPL script then.
>
>
> How would you like to handle corresponding function calls?
>
> https://cwe.mitre.org/data/definitions/690.html
>
> Regards,
> Markus
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150509/51c408ce/attachment.html>
