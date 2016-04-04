From: dnietoc@gmail.com (Diego Nieto Cid)
Date: Mon, 4 Apr 2016 05:34:23 -0300
Subject: [Cocci] Insert statement before every return point
In-Reply-To: <20160406060256.GA18795@osadl.at>
References: <20160403063412.GA2982@hird.mnieto.com.ar>
 <alpine.DEB.2.02.1604030728030.2018@localhost6.localdomain6>
 <20160406060256.GA18795@osadl.at>
Message-ID: <20160404083423.GA2371@hird.mnieto.com.ar>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

El 6 abr 2016, a las 03:02, Nicholas Mc Guire <der.herr@hofr.at> escribi?:
>
>the canary would need to be declared
>volatile or gcc will optimize it out.

Yes, indeed. I discovered it the hard way after applying Julia's suggestion :(
Thanks.

BTW, I used the DIVIDE_BY_ZERO macro because Coccinelle was failing
when inline assembly was used, like this:

--------8<-------------8<----------8<------------8<-------
init_defs_builtins: /usr/lib/coccinelle/standard.h
-----------------------------------------------------------------------
processing semantic patch file: ssp3.cocci
with isos from: /usr/lib/coccinelle/standard.iso
-----------------------------------------------------------------------
@@
identifier fn;
fresh identifier canary = "canary_";
@@
 fn (...)
 {
+  volatile int canary = 0xdeadbeef;
   <...
+  if ((canary ^ 0xdeadbeef) != 0)
+      asm volatile ("divl %0"::"r"(0):"eax","edx");
   return ...;
   ...>
 }

162 170
Fatal error: exception Failure("plus: parse error: \n = File \"ssp3.cocci\", line 10, column 11,  charpos = 162\n    around = 'volatile', whole content = +      asm volatile (\"divl %0\"::\"r\"(0):\"eax\",\"edx\");\n")
--------8<-------------8<----------8<------------8<-------

Is it because I'm using GCC extensions?

Regards,
Diego.
