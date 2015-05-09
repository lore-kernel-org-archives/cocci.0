From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Sat, 9 May 2015 12:31:29 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <554DB33D.2000000@users.sourceforge.net>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>
 <554DB33D.2000000@users.sourceforge.net>
Message-ID: <CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

ok
i want that my script detects only the dereference of a pointer when it is
not checked different from NULL.
i will aplly my script to an embedded project. so it's so delicate.
 i want that my script detects only the dereference of a pointer and not
the declaration ( exemple : int *k ;)  or the cast ( exemple : int *k ;)  or
the initialisation ( (int) *s = &1;)
this my script
@r@
position p1 != {safe1.p,safe2.p};
expression x;
identifier y;
@@

*x at p1->y

@script:python@
x << r.x;
p1 << r.p1;

@@
l0= p1[0].file
l1 = p1[0].line

print " *file : (%s ) the pointer  %s must be tested different to NULL
before access on line %s"% (l0,x,l1)


@safe3 exists@
position po;
expression x1,e1;
statement S1;
@@

if (x1 != NULL || ...) {
  ... when != x1 = e1
      when any
   *x1 at po
  ...
} else S1

@safe4 exists@
position po;
expression x1,e1;
statement S1;
@@

if (x1 == NULL || ...) {
  ...
  return ...;
} else S1
... when != (x1 = e1)
    when any
  *x1 at po
@safe5 exists@
position po;
type T;
expression e1;
@@
(
  ((T)* e1 at po)

|

  ((T) *e1 at po)
)
@r1@
position po1 != {safe3.po,safe4.po,safe5.po};
expression x1;
@@

* *x1 at po1

@script:python@
x1<< r1.x1;
po1 << r1.po1;

@@
l2= po1[0].file
l3 = po1[0].line

print " *file : (%s ) the pointer  %s must be tested different to NULL
before access on line %s"% (l2,x1,l3)

*************************************

can you check it please ?



2015-05-09 9:11 GMT+02:00 SF Markus Elfring <elfring@users.sourceforge.net>:

> > I am asking you if you can help me to implement a semantic patch
>
> Yes, of course.
>
>
> > which allows to print out a warning before any pointer access,
>
> This is possible in principle.
>
>
> > if the pointer value not tested different from NULL.
>
> Will it be more useful to look only at the value sources?
>
> Did you inspect any examples?
> Where do you get difficulties in your evolving SmPL scripts?
>
> Regards,
> Markus
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150509/d841e477/attachment.html>
