From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sun, 21 Dec 2014 13:24:40 +0100
Subject: [Cocci] Change function invocations argument
In-Reply-To: <alpine.DEB.2.02.1412211302450.2068@localhost6.localdomain6>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
 <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
 <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
 <D2F6C23B-F5FF-41DE-86B3-8C7210DA61BD@gmail.com>
 <alpine.DEB.2.02.1412211157000.2068@localhost6.localdomain6>
 <2BD158D5-96AC-4BEC-81B9-F07A54C7BEEB@gmail.com>
 <5496B54D.8050501@users.sourceforge.net>
 <alpine.DEB.2.02.1412211302450.2068@localhost6.localdomain6>
Message-ID: <6C06025D-6720-4BBD-9D44-75802D8A5B53@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

That?s right. I wanted to remove external parentheses, which wasn?t done if employing only e2/e3.
I hadn?t realized using (e2)/(e3) would take care of both cases (with/without parentheses), though.

BTW, is there an easy way to remove **all** unneeded parentheses, project wide?

Thanks.
> On 21 Dec 2014, at 13:04, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Sun, 21 Dec 2014, SF Markus Elfring wrote:
> 
>>> @@ typedef long_u, uintmax_t; expression e1, e2, e3; @@
>>> 
>>>    put_bytes(
>>>        e1,
>>> (
>>> -       (long_u)(e2)
>>> |
>>> -       (long_u)e2
>>> )
>>> +       (uintmax_t)e2
>>>        ,
>>> (
>>> -       (int)(e3)
>>> +       (unsigned int)e3
>>> |
>>> -       (int)e3
>>> +       (unsigned int)e3
>>> |
>>>        e3
>>> )
>>>    )
>> 
>> Can it be that you need to fiddle with SmPL disjunctions a bit less here
>> because the metavariable type (or an isomorphism) will take care for
>> additional parentheses around the affected expressions?
>> 
>> How do you think about the applicability of the following approach?
>> 
>> @parameter_cast_replacement@
>> expression e1, e2, e3;
>> typedef long_u, uintmax_t;
>> @@
>> put_bytes(e1,
>> -          (long_u)
>> +          (uintmax_t)
>>           e2,
>> (
>> -          (int)
>> +          (unsigned int)
>>           e3
>> |
>>           e3
>> )
>>          )
> 
> It looks like Eliseo wants to get rid of the parentheses, which your 
> approach does not do.  On the other hand, Markus is right that 
> 
>>> (
>>> -       (long_u)(e2)
>>> |
>>> -       (long_u)e2
>>> )
> 
> could be just
> 
> -       (long_u)(e2)
> 
> and an isomorphism will allow it to match the case where the parentheses 
> are already removed as well.
> 
> julia
> 
> 
>> 
>> Regards,
>> Markus
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
