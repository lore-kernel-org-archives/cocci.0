From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Fri, 12 May 2017 13:27:41 +0200
Subject: [Cocci] howto conditional match
Message-ID: <3f759e1c-e081-910b-9012-a5d3e5902f48@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have the following rule in my cocci script. Actually, want to apply 
the patch conditionally, ie. when type S matches one or more structure 
definitions. Initially I had 'struct Foo *drvr, ...' but that did not 
work for me. Any hints are appreciated.

Regards,
Arend

@@
identifier func;
identifier drvr;
type T;
expression list es;
type S;
@@
         T func(S *drvr, ...)
         {
                 <...
-               brcmf_err(es);
+               brcmf_derr(drvr, es);
                 ...>
         }
