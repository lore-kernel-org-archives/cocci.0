From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 23 Dec 2014 16:20:45 +0100
Subject: [Cocci] RFC - simple scanners and matching macros
Message-ID: <20141223152045.GA6138@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi !

 writing some cocci file to detect some completion related 
 issues - for the function cases it works fine. If its correct
 I'm not sure. What the first one should be doing is
 find any siutation where a completion is reinitialized
 with init_completion rather than reinit_completion.
 so find the first init_completion() and take the position
 (rule c) then check if the completion object was
 used or passed to a function before the next init_completion
 Q: do I need to handle more than those 4 cases to catch all ?

 The second one should find sequential init_completion() of the
 same struct completion without that they are used in between
 so basically the inverse case of the first - I'm not sure if 
 its worth the trouble though - in 3.18.0 there are 2 cases 
 found and both were correct findings

 The third scanner was to search for DECLARE_COMPLETION used
 in functions for declearing struct completion on automatic variables
 and transform them to DECLARE_COMPLETION_ONSTACK. Simple problem 
 it is not working... - obviously Im overlooking something - it 
 will just run through and report nothin.

 Any hint would be appreciated.

 One more procedural question - the patch-set generated should be 
 posted here+lkml for a first review or should it go out to all 
 the subsystem lists whose code is affected in CC as well ? 

thx!
hofrat

first working case:
===================

@c@
expression cmp;
position p;
@@

 init_completion at p(cmp)

@d@
expression E,c.cmp;
identifier f;
position c.p,p1;
@@

  init_completion at p(cmp)
  ...
(
  E = cmp
|
  E = &cmp
|
  f(..., cmp,...)
|
  f(..., &cmp,...)
)
  ...
- init_completion at p1(cmp)
+ reinit_completion1(cmp)


2nd working case:
=================

@c@
expression cmp;
position p;
@@

 init_completion at p(cmp)

@d@
expression E,c.cmp;
identifier f;
position c.p,p1;
@@

  init_completion at p(cmp)
  ... when != E = cmp
      when != E = &cmp
      when != f(..., cmp,...)
      when != f(..., &cmp,...)
- init_completion at p1(cmp);


the not-working case:
=====================
@e@
expression cmp;
identifier f;
position p;
@@

f(...) {
  ...
- DECLARE_COMPLETION at p(cmp);
+ DECLARE_COMPLETION_ONSTACK(cmp);
  ...
} 
