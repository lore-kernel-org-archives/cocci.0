From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 Aug 2016 14:24:53 +0200
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <alpine.DEB.2.10.1608011359210.3188@hadrien>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <alpine.DEB.2.10.1608011336590.3188@hadrien>
 <0dbd2dd6-4c68-1f7c-1500-9e5d40047813@users.sourceforge.net>
 <alpine.DEB.2.10.1608011359210.3188@hadrien>
Message-ID: <f5754bb5-24f6-3bcb-6f20-52f278fe8b70@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How do you think about the following SmPL script example?
>>
>> @vz_combined
>>  depends on patch && !context && !org && !report@
>> type T;
>> T* pointer;
>> +statement S;
>> expression express;
>> @@
>>  pointer =
>> -          vmalloc
>> +          vzalloc
>>            (...);
>>  if (!d)
>>     S
>> -memset(d, 0, sizeof(
>> (
>> -T
>> |
>> -*(express)
>> )
>> -));
> 
> OK, I thought you meant to make a big disjunctions for all of the before
> and after functions.

I imagine that it would be nice if the function name pairs could be specified
in a more succinct format for the semantic patch language.
But the discussed approach can work with a recent software version already.


> This is a little better because it is bounded in size.

Thanks ?


> But I don't understand why you have introduced the variable express.

I have noticed that these two SmPL rules differed only in the source code
search specification for the operator "sizeof".
So I would prefer to express this small difference in the script directly.


> The performance issue is that disjunctions on expressions, eg (A | B), are
> implemented as (A | (!A & B)), ie with a negation of all the previous
> options &d with each option.  So it is better to avoid very large
> disjunctions on expressions.

Is the suggested SmPL disjunction still small enough for this concern?

Regards,
Markus
