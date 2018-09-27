From: keescook@google.com (Kees Cook)
Date: Thu, 27 Sep 2018 11:51:15 -0700
Subject: [Cocci] =~ runtime improvements?
Message-ID: <CAGXu5jLfBk6BAiQiKHJdxAFnP72xe_qtBDOizoSaAgYvsxTkVQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

This .cocci takes a VERY long time to run against the kernel, and I'd
love to know what I could do to improve it. I assume it's related to
the use of the "=~" operand:

// Replace multi-factor out-of-line products with array_size() usage.
@@
identifier alloc =~ ".*alloc.*";
constant C1, C2, C3;
identifier ISTRIDE, ISIZE, ICOUNT;
expression ESTRIDE, ESIZE, ECOUNT;
expression PRODUCT, OTHER;
@@

(
  PRODUCT = ((C1)) * ((C2)) * ((C3))
|
  PRODUCT = ((C1)) * ((C2))
|
- PRODUCT = ((ICOUNT)) * ((ISTRIDE)) * ((ISIZE))
+ PRODUCT = array3_size(ICOUNT, ISTRIDE, ISIZE)
|
- PRODUCT = ((ICOUNT)) * ((ISTRIDE)) * ((ESIZE))
+ PRODUCT = array3_size(ICOUNT, ISTRIDE, ESIZE)
|
- PRODUCT = ((ICOUNT)) * ((ESTRIDE)) * ((ESIZE))
+ PRODUCT = array3_size(ICOUNT, ESTRIDE, ESIZE)
|
- PRODUCT = ((ECOUNT)) * ((ESTRIDE)) * ((ESIZE))
+ PRODUCT = array3_size(ECOUNT, ESTRIDE, ESIZE)
|
- PRODUCT = ((ICOUNT)) * ((ISIZE))
+ PRODUCT = array_size(ICOUNT, ISTRIDE, ISIZE)
|
- PRODUCT = ((ICOUNT)) * ((ESIZE))
+ PRODUCT = array_size(ICOUNT, ESIZE)
|
- PRODUCT = ((ECOUNT)) * ((ESIZE))
+ PRODUCT = array_size(ECOUNT, ESIZE)
)
  ... when != PRODUCT = OTHER
  alloc(..., PRODUCT, ...)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
