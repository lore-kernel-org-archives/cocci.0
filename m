From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 17 Aug 2017 18:50:07 +0200
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <alpine.DEB.2.20.1708171818300.3748@hadrien>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
 <alpine.DEB.2.20.1708171721280.3748@hadrien>
 <alpine.DEB.2.20.1708171818300.3748@hadrien>
Message-ID: <1a936e2d-a2aa-5e2e-923b-bfc585bda5c6@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> ... when any should be <...
> 
> I have told you exactly what to do here.

You are right in the sense that I misinterpreted your change suggestion.


> The line above currently contains ... when any.  It (and only it) should be
> completely removed and changed to <...

But I find it inappropriate to enclose the function call code by an optional
SmPL nest construct.


> Nowhere do I suggest to put <... ... when any ...>

The suggested script variant seems to work finally.
Thanks for your information.

@replacement@
identifier action, var, work;
type T, X;
@@
 T work(...)
 {
 ... when any
 X* var;
 <...
 var = action(...,
              sizeof(
-                    X
+                    *var
                    ),
              ...
             )
 ...>
 }


Now I wonder why the SmPL construct ?<+... ...+>? does not produce the same
transformation result for the source file ?fs/pstore/ram.c?.

Regards,
Markus
