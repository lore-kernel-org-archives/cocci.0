From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 10 Jan 2017 22:14:45 +0100 (CET)
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <CAGXu5jLT8w6bK8SC4=Wne1BtfPsALiBSeyr6OK_jsCfaiJ+KRg@mail.gmail.com>
References: <20170109231323.GA89642@beast>
 <alpine.DEB.2.20.1701101927070.1981@hadrien>
 <CAGXu5j+Nk9r7K=FJe4v5b8mX_Fn411JMGks2sueyOFS2aTo1Ow@mail.gmail.com>
 <alpine.DEB.2.20.1701102028300.1981@hadrien>
 <CAGXu5jLT8w6bK8SC4=Wne1BtfPsALiBSeyr6OK_jsCfaiJ+KRg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701102207590.1981@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

OK, I have the impression that what you are looking for is the following,
that currently does not seem to work well. Still maybe it gives an idea.

The basic pattern is the following sequence:

1. copy_from_user
2. test on a field of the copied value
3. another copy_from_user
4. a use of the same field as tested in step 2 from the structure obtained
by the second copy_from_user or a function call with the structure as an
argument

In the case where the second copy_from_user stores the result in a
pointer, then a return with no reference of the tested field is also a
concern, unless, the pointer was already kfreed.

julia

----

/// Recopying from the same user buffer frequently indicates a pattern of
/// Reading a size header, allocating, and then re-reading an entire
/// structure. If the structure's size is not re-validated, this can lead
/// to structure or data size confusions.
///
// Confidence: Moderate
// Copyright: (C) 2013 Kees Cook, Chromium.  GPLv2.
// URL: http://coccinelle.lip6.fr/
// Comments:
// Options: --no-includes --include-headers

virtual report
virtual org

@start@
expression dest1,src,size1;
@@

(
copy_from_user(dest1, src, size1)
|
__copy_from_user(dest1, src, size1)
)

@cfu_twice1 exists@
position p1,p2,p3,p4;
expression s1,s2 <= start.src;
expression start.dest1, dest2, start.size1, size2, e1, e2, start.src, e;
assignment operator aop;
binary operator binop = {<,<=,>,>=};
identifier f,fld;
@@

(
copy_from_user at p1(\(&dest1\|dest1\), src, size1)
|
__copy_from_user at p1(\(&dest1\|dest1\), src, size1)
)
 ... when != s1 aop e1
     when != s1 ++
     when != s1 --
     when != ++ s1
     when != -- s1
     when != copy_from_user(...)
     when any
(
  dest1.fld at p2 binop e
|
  dest1->fld at p2 binop e
)
 ... when != s2 aop e2
     when != s2 ++
     when != s2 --
     when != ++ s2
     when != -- s2
     when != copy_from_user(...)
     when any
(
copy_from_user at p3(dest2, src, size2)
|
__copy_from_user at p3(dest2, src, size2)
)
  ...
(
dest2.fld binop e
|
dest2.fld == \(dest1.fld\|dest1->fld\)
|
dest2.fld != \(dest1.fld\|dest1->fld\)
|
dest2.fld = e
|
f(...,&dest2 at p4,...)
|
dest2.fld at p4
)


@script:python depends on org@
p1 << cfu_twice1.p1;
p2 << cfu_twice1.p2;
p3 << cfu_twice1.p3;
p4 << cfu_twice1.p4;
@@

if p1[0].line != p3[0].line:
  cocci.print_main("potentially dangerous double copy_from_user()",p1)
  cocci.print_secs("",p2)
  cocci.print_secs("",p3)
  cocci.print_secs("",p4)

@script:python depends on report@
p1 << cfu_twice1.p1;
p2 << cfu_twice1.p2;
p3 << cfu_twice1.p3;
p4 << cfu_twice1.p4;
@@

if p1[0].line != p3[0].line:
  msg = "test on line %s missing before use on line %s, second copy_from_user on line %s" % (p2[0].line,p4[0].line,p3[0].line)
  coccilib.report.print_report(p1[0], msg)

@cfu_twice2 exists@
position p1,p2,p3,p4;
expression s1,s2 <= start.src;
expression start.dest1, dest2, start.size1, size2, e1, e2, start.src, e;
assignment operator aop;
binary operator binop = {<,<=,>,>=};
identifier f,fld;
@@

(
copy_from_user at p1(\(&dest1\|dest1\), src, size1)
|
__copy_from_user at p1(\(&dest1\|dest1\), src, size1)
)
 ... when != s1 aop e1
     when != s1 ++
     when != s1 --
     when != ++ s1
     when != -- s1
     when != copy_from_user(...)
     when any
(
  dest1.fld at p2 binop e
|
  dest1->fld at p2 binop e
)
 ... when != s2 aop e2
     when != s2 ++
     when != s2 --
     when != ++ s2
     when != -- s2
     when != copy_from_user(...)
     when any
(
copy_from_user at p3(dest2, src, size2)
|
__copy_from_user at p3(dest2, src, size2)
)
  ...
(
__impossible__(); // need a statement here to satisfy the parser
|
dest2->fld binop e
|
dest2->fld == \(dest1.fld\|dest1->fld\)
|
dest2->fld != \(dest1.fld\|dest1->fld\)
|
dest2->fld = e
|
dest2->fld at p4
|
f(...,dest2 at p4,...)
|
kfree(dest2);
|
return at p4 ...;
)

@script:python depends on org@
p1 << cfu_twice2.p1;
p2 << cfu_twice2.p2;
p3 << cfu_twice2.p3;
p4 << cfu_twice2.p4;
@@

if p1[0].line != p3[0].line:
  cocci.print_main("potentially dangerous double copy_from_user()",p1)
  cocci.print_secs("",p2)
  cocci.print_secs("",p3)
  cocci.print_secs("",p4)

@script:python depends on report@
p1 << cfu_twice2.p1;
p2 << cfu_twice2.p2;
p3 << cfu_twice2.p3;
p4 << cfu_twice2.p4;
@@

if p1[0].line != p3[0].line:
  msg = "test on line %s missing before use or return on line %s, second copy_from_user on line %s" % (p2[0].line,p4[0].line,p3[0].line)
  coccilib.report.print_report(p1[0], msg)
