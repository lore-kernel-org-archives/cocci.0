From: mstefani@redhat.com (Michael Stefaniuc)
Date: Fri, 29 Apr 2016 19:36:19 +0200
Subject: [Cocci] Odd behaviour for ... and sub-expressions
Message-ID: <57239B93.9020600@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm observing an odd behaviour difference when using an ellipses
following a plain expression or a sub-expression in <+... ...+>

Following coccinelle rule does not behave as expected:

// Sanity check to not use a RECT field in the SetRect.
@@
expression rect;
identifier fld;
@@
  SetRect(&rect, ...,
-                     <+... rect.fld ...+>
+                     BADBADBAD
                                ,...)

It does not matches cases where the bad subexpression is the last
argument of the function call. E.g. for

void foo(void)
{
    RECT r;
    SetRect(&r, 0, 0, r.left, 0);
    SetRect(&r, 0, 0, 0, r.top);
    SetRect(&r, 0, 0, r.left + 1, 0);
    SetRect(&r, 0, 0, 0, r.top + 1);
}

it modifies just the 1st and 3rd SetRect() call while it should match
all 4 cases.

If I just use rect.fld without the <+... ...+> the rule will match
correctly both the 1st and 2nd SetRect() call aka it matches at the end
of the argument list too.

Is this a bug? I'm running coccinelle 1.0.4.

thanks
bye
     michael

P.S.: As a workaround I have created a separate rule for the last
argument and that works.
