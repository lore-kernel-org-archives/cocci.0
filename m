From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 17 Aug 2017 18:11:50 +0200
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <alpine.DEB.2.20.1708171759271.3748@hadrien>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
 <alpine.DEB.2.20.1708171721280.3748@hadrien>
 <a0bda451-ef87-2317-2abc-62b1bd59e386@users.sourceforge.net>
 <alpine.DEB.2.20.1708171759271.3748@hadrien>
Message-ID: <e6f7b8c2-d1e6-ccc3-dec2-26880450a69a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> ... when any should be ...>
>>
>> I am unsure if I interpret your suggestion correctly.
> 
> No.  Go read the original message again. It says exactly what to do and
> where it should be done.

Your hint might be nice.


> Eg, my message has two comments, but you have made three changes, which is not correct.

I have tried out to convert the SmPL ellipsis into the optional dot variant.

But I wonder still about the error message ?minus: parse error:?
for an adjusted SmPL script variant.

@replacement@
identifier action, var, work;
type T, X;
@@
 T work(...)
 {
 ... when any
 X* var;
 <... ... when any ...>
 var = action(...,
              sizeof(
-                    X
+                    *var
                    ),
              ...
             )
 <... ... when any ...>
 }


Regards,
Markus
