From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 25 Sep 2015 17:51:01 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <56051D2B.5040802@samsung.com>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
Message-ID: <56056D65.7070205@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> + at rs@
>>> +position p;
>>> +typedef bool, u8, u16, u32, u64, s8, s16, s32, s64;
>>> +{char, short int, int, long, long long, s8, s16, s32, s64} vs;
>> Can it matter to specify also the type modifier "signed" in this SmPL approach?
>> http://coccinelle.lip6.fr/docs/main_grammar005.html#ctype_qualif
> According to my tests it does not matter.
> Btw I should replace short int, with short,

I have got an other view on such an implementation detail around
explicit SmPL specifications.


> to allow catch short intergers.

Do you assume that the Coccinelle software will handle more data type
variants for you automatically?


>>> +@@
>>> +
>>> +vu at p = vs
>>> +
>>> + at r@
>>> +position rs.p;
>>> +identifier v, f;
>>> +statement S1, S2;
>>> +expression e;
>>> +@@
>>> +
>>> +*v at p = f(...);
>> Do you try to check here if the value receiver is at the same source code
>> position from the SmPL rule "rs"?
> Yes.

I imagine that there is an open issue in this SmPL approach then.
How should a return value from a function call and a variable access
work at the same place?


> Is there better way to do it?

Do you need to distinguish source code positions a bit more with
corresponding SmPL variables?

Regards,
Markus
