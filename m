From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sun, 21 Dec 2014 12:19:11 +0100
Subject: [Cocci] Change function invocations argument
In-Reply-To: <alpine.DEB.2.02.1412211216070.2068@localhost6.localdomain6>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
 <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
 <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
 <D2F6C23B-F5FF-41DE-86B3-8C7210DA61BD@gmail.com>
 <alpine.DEB.2.02.1412211157000.2068@localhost6.localdomain6>
 <2BD158D5-96AC-4BEC-81B9-F07A54C7BEEB@gmail.com>
 <alpine.DEB.2.02.1412211216070.2068@localhost6.localdomain6>
Message-ID: <FF8588AC-16A0-4737-86BF-D2B05B419A01@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Ok.

Thanks very much.
Coccinelle is going to save me much manual work.
And what is more important: many massive code-quality improving refactorings, which probably wouldn?t be done if manually, will be done this way.
As I said at the beginning, excellent tool.
Congrats!

> On 21 Dec 2014, at 12:16, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Sun, 21 Dec 2014, Eliseo Mart?nez wrote:
> 
>> Sorry, forget about previous message. Everything?s ok.
>> As it happens sometimes, I had run over this a thousand times, but I didn?t see the pitfall until trying to explain to someone else.
>> The point is that, in fact, there are no (int)(e3) or (int)e3 occurrences in my code. I hadn?t realized that before.
>> First version worked right because each independent rule did it?s work on its own (rules about e3 doing nothing, but being applied after rules about e2 had already done their work).
>> Second version doesn?t work because it forces a match in both e2 and e3 variants.
>> This is, both approaches are not exactly equivalent, and second version doesn?t in fact match anything in my case.
>> 
>> So, I could just remove everything related to e3. But just for the sake of learning, I slightly modified the second version this way:
>> 
>> ```
>> @@ typedef long_u, uintmax_t; expression e1, e2, e3; @@
>> 
>>    put_bytes(
>>        e1,
>> (
>> -       (long_u)(e2)
>> |
>> -       (long_u)e2
>> )
>> +       (uintmax_t)e2
>>        ,
>> (
>> -       (int)(e3)
>> +       (unsigned int)e3
>> |
>> -       (int)e3
>> +       (unsigned int)e3
>> |
>>        e3
>> )
>>    )
>> 
>> ```
>> 
>> And now it works great.
>> Regarding what you say about moving plus lines within branches, I had indeed suspected that, and tried both versions, with identical results.
>> Last version of the patch above still has a plus outside branches when dealing with e2, and it?s working great? 
>> From your comment, though, it seems that?s not expected usage. So, what do you advice? should I not count of that in the future, and always replicate plus lines within branches?
> 
> Perhaps it work for expressions, but not for statements.
> 
> Anyway, it is safer to duplicate.
> 
> julia
> 
> 
>> 
>>> On 21 Dec 2014, at 11:57, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>> 
>>> 
>>> 
>>> On Sun, 21 Dec 2014, Eliseo Mart?nez wrote:
>>> 
>>>> Ok. Finally I have it working. There?s still a gotcha, though.
>>>> The first version of my spatch contained these rules:
>>>> 
>>>> ```
>>>> @@ typedef long_u, uintmax_t; expression e1, e2, e3; @@
>>>> 
>>>> -   put_bytes(e1, (long_u)(e2), e3)
>>>> +   put_bytes(e1, (uintmax_t)e2, e3)
>>>> 
>>>> @@ expression e1, e2, e3; @@
>>>> 
>>>> -   put_bytes(e1, (long_u)e2, e3)
>>>> +   put_bytes(e1, (uintmax_t)e2, e3)
>>>> 
>>>> @@ expression e1, e2, e3; @@
>>>> 
>>>> -   put_bytes(e1, e2, (int)(e3))
>>>> +   put_bytes(e1, e2, (unsigned int)e3)
>>>> 
>>>> @@ expression e1, e2, e3; @@
>>>> 
>>>> -   put_bytes(e1, e2, (int)e3)
>>>> +   put_bytes(e1, e2, (unsigned int)e3)
>>>> 
>>>> ```
>>>> 
>>>> Those work ok.
>>>> Then, I tried a second version, trying to compact those rules into a single, more expressive one:
>>>> 
>>>> ```
>>>> @@ typedef long_u, uintmax_t; expression e1, e2, e3; @@
>>>> 
>>>>   put_bytes(
>>>>       e1,
>>>> (
>>>> -       (long_u)(e2)
>>>> |
>>>> -       (long_u)e2
>>>> )
>>>> +       (uintmax_t)e2
>>>>       ,
>>>> (
>>>> -       (int)(e3)
>>>> |
>>>> -       (int)e3
>>>> )
>>>> +       (unsigned int)e3
>>>>   )
>>>> 
>>>> ```
>>>> 
>>>> That parses ok but just does nothing. So, it seems it doesn?t match anything, but I don?t understand why.
>>>> Could you please explain?
>>> 
>>> I'm surprised that it parses OK.  Normally, you can't put + code on a 
>>> disjunction.  You have to propagate it into each of the branches.  Try 
>>> that.
>>> 
>>> julia
>>> 
>>> 
>>>> 
>>>>> On 20 Dec 2014, at 21:51, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>>> 
>>>>> 
>>>>> 
>>>>> On Sat, 20 Dec 2014, Eliseo Mart?nez wrote:
>>>>> 
>>>>>> Great. That worked. Just one more thing, please.
>>>>>> Some of the replacements done by the rule before leave literals of the form ?(uintmax_t)34?.
>>>>>> I would like to use an unsigned constant in those cases. This is, something like ?34u?. 
>>>>>> So I add the following rule:
>>>>>> 
>>>>>> ```
>>>>>> @@ expression e1, e3; constant c2; @@
>>>>>> 30 
>>>>>> 31 - put_bytes(e1, (uintmax_t)c2, e3)
>>>>>> 32 + put_bytes(e1, c2, e3)
>>>>>> ```
>>>>>> 
>>>>>> That does the work, except adding the ?u?. How could I do that?
>>>>>> Is it possible adding something literally in the output?
>>>>>> Is it possible to somehow say in line 32 ?render c2 but with u suffix??
>>>>> 
>>>>> It is possible, but somewhat awkward.  Here is a simpler example that you 
>>>>> can adapt to your case:
>>>>> 
>>>>> @r@
>>>>> typedef uintmax_t;
>>>>> constant c;
>>>>> @@
>>>>> 
>>>>> (uintmax_t)c
>>>>> 
>>>>> @script:python s@
>>>>> c << r.c;
>>>>> cu;
>>>>> @@
>>>>> 
>>>>> coccinelle.cu = "%su" % (c)
>>>>> 
>>>>> @@
>>>>> constant r.c;
>>>>> identifier s.cu;
>>>>> @@
>>>>> 
>>>>> - (uintmax_t)c
>>>>> + cu
>>>>> 
>>>>> julia
