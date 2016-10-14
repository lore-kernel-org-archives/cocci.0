From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Fri, 14 Oct 2016 17:54:45 +0530
Subject: [Cocci] [PATCH] Coccinelle: misc: Improve the script for more
 accurate results
In-Reply-To: <66694ba2-9108-b400-e412-d9927f593e16@metafoo.de>
References: <1476354490-25635-1-git-send-email-vaishali.thakkar@oracle.com>
 <alpine.DEB.2.10.1610131814180.3674@hadrien> <57FFBDE0.6000705@oracle.com>
 <66694ba2-9108-b400-e412-d9927f593e16@metafoo.de>
Message-ID: <5800CE8D.5080206@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Friday 14 October 2016 02:21 PM, Lars-Peter Clausen wrote:
> On 10/13/2016 07:01 PM, Vaishali Thakkar wrote:
>>
>>
>> On Thursday 13 October 2016 09:45 PM, Julia Lawall wrote:
>>>
>>>
>>> On Thu, 13 Oct 2016, Vaishali Thakkar wrote:
>>>
>>>> Currently because of the left associativity of the operators,
>>>> pattern IRQF_ONESHOT | flags does not match with the pattern
>>>> when we have more than one flag after the disjunction. This
>>>> eventually results in giving false positives by the script.
>>>> The patch eliminates these FPs by improving the rule.
>>>>
>>>> Also, add a new rule to eliminate the false positives given by
>>>> the new line issue.
>>>>
>>>> Misc:
>>>>
>>>> 1. Add support for the context, org and report mode in the case
>>>>    of devm_request_threaded_irq
>>>> 2. To be consistent with other scripts, change the confidence
>>>>    level to 'Moderate'
>>>
>>> I'm getting a lot more reports for context mode than for patch mode, eg
>>> for sound/pcmcia/vx/vxpocket.c.  Is this normal?
>>
>> This seems to be because of the ... in '*request_threaded_irq at p(...)'.
>> Usually I think we should have same rules for the patch  and context mode.
>> But the original code does not do that. So, I was not sure if that was
>> intentional or not.
>> [just in case, person wants to check all cases of these functions using
>> context mode]
> 
> To be honest, I don't remember if it was intentional or not. But looking at
> it now, I'd say context mode should use the same pattern as the report mode.
> The way it is right now context mode certainly generates a fair amount of
> false positives.
> 
> As for your patch I'd say split this into multiple patches, one patch to add
> the missing devm_ variants to the context and report mode and one patch to
> improve the matching, since these are two independent changes.

Sure. I'll send the revised version with 3 patches. One more with changing 
the rule of context mode. 

> 

-- 
Vaishali
