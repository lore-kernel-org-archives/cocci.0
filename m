From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Sat, 28 Jan 2017 14:41:58 +0530
Subject: [Cocci] position confusion?
In-Reply-To: <1485591488.4812.2.camel@sipsolutions.net>
References: <1485558606.14579.15.camel@sipsolutions.net>
 <9d692cfd-f6a0-fef4-bcbb-84564e60beb5@oracle.com>
 <1485591488.4812.2.camel@sipsolutions.net>
Message-ID: <034eff0a-e9df-bf26-f9ac-5cb3cae7ae1b@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Saturday 28 January 2017 01:48 PM, Johannes Berg wrote:
> On Sat, 2017-01-28 at 12:10 +0530, Vaishali Thakkar wrote:
>> On Saturday 28 January 2017 04:40 AM, Johannes Berg wrote:
>>> This is nonsense, but I don't see why it shouldn't parse:
>>
>> Hi,
>>
>>> @a@
>>> type T;
>>> identifier x;
>>> position p;
>>> @@
>>> T x at p = { };
>>>
>>> @b@
>>> type T;
>>> identifier x;
>>> position p;
>>
>> This should be "position p != a.p;".
>
> That has no effect on the point I was trying to make. I told you the
> spatch was nonsense ... :)
>
>>> @@
>>> T x at p = { };
>>>
>>> @@
>>> position p != a.p;
>>> position q != b.p;
>>
>> And here no need to put constraint for q.
>
> There was no need to put a constraint anyway, again, the whole patch
> made no sense. But assume I wanted to have p and q in different
> positions, or whatever. Note that I didn't even *use* @p in the rule,
> so you're making wrong assumptions.

Got your point now. Just tried to solve the parsing error in the 
previous mail. :)

>> position p != {a.p, b.p};
>
> Nevertheless, that's something I learned.
>
> johannes
>
