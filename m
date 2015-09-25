From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 25 Sep 2015 12:08:43 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <56041BE5.5010005@users.sourceforge.net>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net>
Message-ID: <56051D2B.5040802@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/24/2015 05:51 PM, SF Markus Elfring wrote:
>> + at rs@
>> +position p;
>> +typedef bool, u8, u16, u32, u64, s8, s16, s32, s64;
>> +{char, short int, int, long, long long, s8, s16, s32, s64} vs;
> Can it matter to specify also the type modifier "signed" in this SmPL approach?
> http://coccinelle.lip6.fr/docs/main_grammar005.html#ctype_qualif

According to my tests it does not matter.
Btw I should replace short int, with short, to allow catch short intergers.

>
>
>> +{unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long, size_t, bool, u8, u16, u32, u64} vu;
> How do you think about to reformat such a data type enumeration?

If you mean split line to be below 80 chars, OK.

>
>
>> +@@
>> +
>> +vu at p = vs
>> +
>> + at r@
>> +position rs.p;
>> +identifier v, f;
>> +statement S1, S2;
>> +expression e;
>> +@@
>> +
>> +*v at p = f(...);
> Do you try to check here if the value receiver is at the same source code
> position from the SmPL rule "rs"?

Yes.
Generally I want to catch all assignments of signed function result to unsigned var.
In this script I have implemented it this way:
1. Look for all assignments 'unsigned = signed' (rs rule).
2. Check if signed from rs rule looks as a function call.

Is there better way to do it?

Regards
Andrzej

>
> Regards,
> Markus
>
