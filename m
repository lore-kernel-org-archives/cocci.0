From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 14 Dec 2016 20:23:32 +0100
Subject: [Cocci] Determination of static data types by SmPL constraints?
Message-ID: <a0aae8e0-28f3-d841-8750-3b56333bf07a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am using the following bit of code for semantic patch language scripts.

?
@find_static depends on safety_check@
identifier safety_check.work;
position safety_check.pos;
@@
 static void work at pos(...)
 {
  ...
 }
?


The Coccinelle software was extended for the handling of special constraints
by the execution of embedded scripts in supported programming languages
to some degree.
I got the idea that this functionality could also be used now to check
the usage of a storage-class specifier like ?static? in data types for further
source code analysis approaches.

* How should such a specifier be determined by the programming interfaces
  of ?Coccilib??

* Would you like to compare run time characteristics for the execution
  of the shown SmPL rule and a similar constraint implemented as
  an OCaml (or Python) script?

Regards,
Markus
