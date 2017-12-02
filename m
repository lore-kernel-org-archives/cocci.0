From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 2 Dec 2017 10:20:06 +0100
Subject: [Cocci] =?utf-8?q?Transformation_challenges_with_SmPL_around_?=
 =?utf-8?b?4oCcTElTVF9GT1JfRUFDSF9FTlRSWeKAnQ==?=
In-Reply-To: <alpine.DEB.2.20.1712020913040.2168@hadrien>
References: <alpine.DEB.2.20.1712020913040.2168@hadrien>
Message-ID: <e1ac4060-67e9-973b-e4c7-6faa476af34e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I think I've found a bug in spatch,

You showed another opportunity for further development considerations.


>> or maybe I'm just using it wrong.

Not really.

But the specification in the shown small SmPL script could be adjusted.


>> - LIST_FOR_EACH_ENTRY(c,f,g,member) S
>> + hlist_for_each_entry(c,f,member) S

> Actually, the problem is that you have removed S and dded it back.
> Then you are relying on Coccinelle to do the pretty printing,
> and all comments will be dropped.  Just rewrite your rule as follows,
> and everything will be fine:

> - LIST_FOR_EACH_ENTRY(c,f,g,member)
> + hlist_for_each_entry(c,f,member)
>   S

How do you think about further possibilities?

Can it be also sufficient to express only the source code adjustment for
two details?

* Replacement of a macro name

* Deletion (or omission) of a parameter


@adjustment@
expression ex;
statement S;
@@
-LIST_FOR_EACH_ENTRY
+hlist_for_each_entry
 (..., ...,
-ex,
 ...)
 S

Regards,
Markus
