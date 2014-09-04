From: mcuddie@qnx.com (Mitchell Cuddie)
Date: Thu, 4 Sep 2014 17:07:25 +0000
Subject: [Cocci] Matching Function Pointer
Message-ID: <1409850429.4797.13.camel@QNXWS8653-PC>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia,

I am putting together a patch to find instances of a switch on a pointer
typed argument. The patch below seems to work unless the argument is a
function pointer in which case it doesn't match. How does one match a
function pointer.

Secondly is there a way to have it mark if x is any type other than int?

@r@
expression *x; type t; position p1;
@@
* switch ((t)x)
 {
    case ...:@p1
        ...
 }

Mitchell
