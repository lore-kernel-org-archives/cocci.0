From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 27 Dec 2015 01:36:27 +0300
Subject: [Cocci] [PATCH v2] coccinelle: api: check for propagation of
 error from platform_get_irq
In-Reply-To: <alpine.DEB.2.02.1512262330430.2070@localhost6.localdomain6>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
 <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
 <567F141C.8010000@cogentembedded.com>
 <alpine.DEB.2.02.1512262330430.2070@localhost6.localdomain6>
Message-ID: <567F166B.7030208@cogentembedded.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/27/2015 01:32 AM, Julia Lawall wrote:

>>> The error return value of platform_get_irq seems to often get dropped.
>>>
>>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>>
>>> ---
>>>
>>> v2: Check for the direct return case also.  Added some mailing lists of
>>> common offenders.
>>>
>>> diff --git a/scripts/coccinelle/api/platform_get_irq_return.cocci
>>> b/scripts/coccinelle/api/platform_get_irq_return.cocci
>>> new file mode 100644
>>> index 0000000..44680d0
>>> --- /dev/null
>>> +++ b/scripts/coccinelle/api/platform_get_irq_return.cocci
>>> @@ -0,0 +1,58 @@
>>> +/// Propagate the return value of platform_get_irq.
>>> +//# Sometimes the return value of platform_get_irq is tested using <= 0,
>>> but 0
>>> +//# might not be an appropriate return value in an error case.
>>> +///
>>> +// Confidence: Moderate
>>> +// Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
>>> +// URL: http://coccinelle.lip6.fr/
>>> +// Options: --no-includes --include-headers
>>> +
>>> +virtual context
>>> +virtual org
>>> +virtual report
>>> +
>>> +//
>>> ----------------------------------------------------------------------------
>>> +
>>> + at r depends on context || org || report@
>>> +constant C;
>>> +statement S;
>>> +expression e, ret;
>>> +position j0, j1;
>>> +@@
>>> +
>>> +* e at j0 = platform_get_irq(...);
>>> +(
>>> +if at j1 (...) {
>>> +  ...
>>> +  return -C;
>>> +} else S
>>> +|
>>> +if at j1 (...) {
>>> +  ...
>>> +  ret = -C;
>>> +  ...
>>> +  return ret;
>>> +} else S
>>
>>     Well, this seems to also cover the (e <= 0) checks which do make same sense
>> in the light of Linus considering IRQ0 invalid. So I'd be more specific about
>> the checks here -- 0 should indeed be overridden with something if it's
>> considered invalid.
>
> That's what the limitations section says (lines with #).  This doesn't

    Ah, failed to notice those, only saw after replying.

> make any changes, it only makes warnings, which should include the
> limitations information, so perhaps people can consider what it is that
> they really intend to do.
 >
> If you think this is not a good idea, then I can make the test more
> specific.

    Well, looking again, the patch should be good. I just thought its goal was 
to fix the code as well...

> julia

MBR, Sergei
