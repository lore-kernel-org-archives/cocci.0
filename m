From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 Aug 2016 14:45:22 +0200
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <alpine.DEB.2.10.1608011429090.3188@hadrien>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <alpine.DEB.2.10.1608011336590.3188@hadrien>
 <0dbd2dd6-4c68-1f7c-1500-9e5d40047813@users.sourceforge.net>
 <alpine.DEB.2.10.1608011359210.3188@hadrien>
 <f5754bb5-24f6-3bcb-6f20-52f278fe8b70@users.sourceforge.net>
 <alpine.DEB.2.10.1608011429090.3188@hadrien>
Message-ID: <0cdfaa73-d2ba-acc3-523f-559f14fadbc1@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>>> @vz_combined
>>>>  depends on patch && !context && !org && !report@
>>>> type T;
>>>> T* pointer;
>>>> +statement S;
>>>> expression express;
>>>> @@
>>>>  pointer =
>>>> -          vmalloc
>>>> +          vzalloc
>>>>            (...);
>>>>  if (!d)
>>>>     S
>>>> -memset(d, 0, sizeof(
>>>> (
>>>> -T
>>>> |
>>>> -*(express)
>>>> )
>>>> -));
> 
> Actually, this is a mess.  pointer, d, and express are all supposed to be
> the same thing, as they were in the original rule.
> 
> Furthermore, this shows a reason why the original rule was better.

There is a trade-off between several unique SmPL rules and other combined
variants which could eventually work with two SmPL disjunctions.

Regards,
Markus
