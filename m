From: waldemar.rymarkiewicz@gmail.com (Waldemar Rymarkiewicz)
Date: Thu, 15 Sep 2016 07:57:42 +0200
Subject: [Cocci] Match #define in cocci
In-Reply-To: <alpine.DEB.2.10.1609141615560.3033@hadrien>
References: <CAHKzcEN9fcOk1HCar=u+htx=o61xF61VmbO9PeYPBaedTQYDcg@mail.gmail.com>
 <alpine.DEB.2.10.1609141615560.3033@hadrien>
Message-ID: <CAHKzcEMih-YHeaaa6hp1-Hf3PUY7GDdqG90wL6zZwuMjaQv=-g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>
> Could you send the exact semantic patch that you tried?  Coccinelle should
> allos parsing #defines.

Simply

@@
@@
-#define pr_fmt(fmt) KBUILD_MODNAME

works, but

@@
@@
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

fails  with

Fatal error: exception Failure("minus: parse error: \n = File
\"patches/1021-pr_fmt_undef.cocci\", line 4, column 38,  charpos =
59\n    around = '\"', whole content = #define pr_fmt(fmt)
KBUILD_MODNAME \": \" fmt\n")

but even if I want to match just

@@
@@
-#define pr_fmt(fmt) KBUILD_MODNAME  fmt

it also fails with

Fatal error: exception Failure("minus: parse error: \n = File
\"patches/1021-pr_fmt_undef.cocci\", line 4, column 0,  charpos = 21\n
   around = '#define pr_fmt(', whole content = #define pr_fmt(fmt)
KBUILD_MODNAME fmt\n")


Thanks,
/Waldek
