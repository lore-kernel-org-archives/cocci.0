From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 2 Dec 2017 11:03:41 +0100
Subject: [Cocci] =?utf-8?q?Transformation_challenges_with_SmPL_around_?=
 =?utf-8?b?4oCcTElTVF9GT1JfRUFDSF9FTlRSWeKAnQ==?=
In-Reply-To: <alpine.DEB.2.20.1712021046000.2168@hadrien>
References: <alpine.DEB.2.20.1712020913040.2168@hadrien>
 <e1ac4060-67e9-973b-e4c7-6faa476af34e@users.sourceforge.net>
 <alpine.DEB.2.20.1712021046000.2168@hadrien>
Message-ID: <1dacc554-c03c-6d4e-e559-15ac92ac9f80@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @adjustment@
>> expression ex;
>> statement S;
>> @@
>> -LIST_FOR_EACH_ENTRY
>> +hlist_for_each_entry
>>  (..., ...,
>> -ex,
>>  ...)
>>  S
> 
> This is not completely a good idea.

I tried to show another approach.


> The ... in the argument list will match a sequence of things, not a single thing.

How does this information fit to the specification of the SmPL ellipsis
as a placeholder for the last macro parameter?


> It could be:
> 
> -LIST_FOR_EACH_ENTRY
> +hlist_for_each_entry
>  (e1,e2,

Are these metavariables required for such an use case?


> -ex,
>  ...)
>  S

Can such a transformation variant have nicer run time characteristics
in comparison to the initial SmPL script example?

Regards,
Markus
