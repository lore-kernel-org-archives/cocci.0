From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 Jan 2018 10:54:42 +0100
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <alpine.DEB.2.20.1801141003270.7902@hadrien>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
Message-ID: <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> + at initialize:python@
>>
>> The added script rule should get a condition.
>> Would the specification ?depends on report? be appropriate there?
> 
> To my recollection,

I wonder about this wording ?


> which is defined in the initialized is used in all of the cases,

I imagine that you could know it better.


> so there is no need for a depends on.

The default usage mode for the affected SmPL script is ?report?.
https://bottest.wiki.kernel.org/coccicheck#modes

But can an other mode also be occasionally selected here?
How do you think about to avoid the extra initialisation
when only the operation mode ?context? or ?patch? would be active?

Regards,
Markus
