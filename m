From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 30 Dec 2015 13:33:30 +0100
Subject: [Cocci] [PATCH v4] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <alpine.DEB.2.02.1512301227090.2048@localhost6.localdomain6>
References: <1451473583-15333-1-git-send-email-a.hajda@samsung.com>
 <alpine.DEB.2.02.1512301227090.2048@localhost6.localdomain6>
Message-ID: <5683CF1A.1030109@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/30/2015 12:29 PM, Julia Lawall wrote:
> 
> 
> On Wed, 30 Dec 2015, Andrzej Hajda wrote:
> 
>> Unsigned expressions cannot be lesser than zero. Presence of comparisons
>> 'unsigned (<|<=|>|>=) 0' often indicates a bug, usually wrong type of variable.
>> The patch beside finding such comparisons tries to eliminate false positives,
>> mainly by bypassing range checks.
>>
>> gcc can detect such comparisons also using -Wtype-limits switch, but it warns
>> also in correct cases, making too much noise.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v4: added range check detection, added full check in case value holds a result
>>     of signed function
>> v3: added bool type
>> v2: added --all-includes option
>> ---
>> Hi Julia,
>>
>> This version adds range check detection, as a result false positives are almost
>> fully eliminated. Most of kernel patches have been already sent and accepted,
>> but some new bugs appeared since then. I will prepare bugfixes soon.
>>
>> I have enountered one issue, the patch does not detect range check in
>> drivers/leds/leds-tca6507.c:716:
>>     if (ret != 0 || reg < 0 || reg >= NUM_LEDS)
>>
>> Simplified check, responsible for detectin range checks:
>> @@
>> expression v, c;
>> @@
>>
>> * (\( v < 0 \| v <= 0 \)) || (\( v >= c \| v > c \))
>>
>> Is it a bug or expected behavior? Maybe consequence of left-to-right associativity?
> 
> Yes, it would be an associativity problem.  Could you try with || ... 
> added to the right end of your pattern?  That should allow it to let the 
> disjunctions appear anywhere at top level, but I'm not sure to what extent 
> it works when the pattern already contains a disjunction.  You could also 
> try
> 
> A || ... || B || ...
> 

"A || ... || B" does the trick.

Regards
Andrzej
