From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Aug 2015 19:46:45 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: add style check for assignment in if
In-Reply-To: <CAMy_N62KRM6sBa_=sUYtMvLHZG75pJ07anLB8g5mrmzjxNCuvg@mail.gmail.com>
References: <1439659132-4452-1-git-send-email-kborer@gmail.com>
 <alpine.DEB.2.02.1508151930030.2060@localhost6.localdomain6>
 <CAMy_N62KRM6sBa_=sUYtMvLHZG75pJ07anLB8g5mrmzjxNCuvg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1508151940330.2060@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

My version is below.  It adds parentheses in a few more places, and allows 
assignments without a binary operator (b) in the && cases.

Also I threw in a case for things like: if (ret = -ENOENT, !data)

Another thing is that the header is not really correct.  It should be in 
the following format:

/// Short comment of gernal interest
//# More information, eg about potential false positives
///
// Confidence: Moderate
// Copyright: whatever you want, it would be nice to have your name
// URL: http://coccinelle.lip6.fr/
// Comments:
// Options: --no-includes --include-headers

Then you should have:

virtual patch

Otherwise, the kernel infrastructure will not think that the patch mode is 
supported.  No other changes are needed, since no other modes are 
supported.  I don't think that supporting other modes is necessary, since 
I think that checkpatch complains about this issue too.

julia

------------------------

// find checkpatch.pl errors of the type:
//	ERROR: do not use assignment in if condition
//
// This script is designed to correct code where assignments exist in if
// conditions. It is only capable of handling a subset of such problems.
//
// For example:
//
//	if(result = myfun())
//
// would become:
//
//	result = myfun();
//	if(result)
//
// Confidence: Moderate

// if ( (ret = call()) < 0 )
@if2@
expression i;
expression E, E2;
statement S1, S2;
binary operator b;
@@

+ i = E;
  if (
(
  ... b
- (i = E)
+ i
|
- (i = E)
+ i
  b ...
|
- (i = E)
+ i
|
- (i = E),
  E2
)
   ) S1 else S2

// if ( ptr->fun && (ret = ptr->fun()) < 0 )
@if3@
expression i2;
expression E1, E2;
constant c;
binary operator b;
@@

+ if( E1 ) {
+  	i2 = E2;
+ 	if (i2 b c) {
- if( E1 && ((i2 = E2) b c) ) {
  ...
- }
+ 	}
+ }

// if ( (ret = call()) < 0 && ret != -1 )
@if4@
expression i;
expression E, E2;
statement S1, S2;
binary operator b;
@@

+ i = E;
  if (
(
  (...
  b
- (i = E)
+ i
  )
|
  (
- (i = E)
+ i
  b
  ...)
|
- (i = E)
+ i
) && E2 ) S1 else S2

// if ( (ret = call()) < 0 && ret != -1 && ret != -2 )
@if5@
expression i;
expression E, E2, E3;
statement S1, S2;
binary operator b;
@@

+ i = E;
  if (
(
  (...
  b
- (i = E)
+ i
  )
|
  (
- (i = E)
+ i
  b
  ...)
|
- (i = E)
+ i
) && E2 && E3 ) S1 else S2

@@
expression i,e;
statement S1,S2;
@@

if (<+... 
-i = e
+BAD
 ...+>) S1 else S2
