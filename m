From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Sep 2017 16:36:50 +0200
Subject: [Cocci] Checking statement order for patch generation with SmPL
	support
In-Reply-To: <alpine.DEB.2.20.1709071619340.3168@hadrien>
References: <2a2b1ae2-ff84-2bda-3701-548dd9ee1edf@users.sourceforge.net>
 <alpine.DEB.2.20.1709071519240.3168@hadrien>
 <c803beac-9fbe-f52d-18b5-6ef3ca3cbcb3@users.sourceforge.net>
 <alpine.DEB.2.20.1709071619340.3168@hadrien>
Message-ID: <bf3026c0-f5ac-03bf-0e12-8146f25fcda9@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> But I have got difficulties to interpret it in an useful way.
> 
> Coccinelle follows control-flow paths.

This information is generally fine.


> Thers is a control-flow path from the bottom of a loop back up to the top.

I can not follow with my intermediate understanding to such a view
at the moment.

Why was the combination of a call for the function ?strncmp? before a ?queuefree?
really displayed as an update candidate?


>>> @usage@
>>> identifier action, member, release=~"^.+free$";
>>> expression context,e;
>>> @@
>>> *release(context);
>>>  ... when != context = e
>>>      when any  // to get all results
>>> *action(..., (context)->member, ...)
>>
>> Should the SmPL construct ?<+.. ...+>? work also similar to your suggestion?
> 
> <+... ...+> would also not allow context = e after the last match of the
> pattern inside the nest.

This information sounds promising.

I am looking still for possibilities to clarify the overlap better
in the shown functionality.


> A when on a <+... ...+> applies to the entire matched region.

Can the parameter ?when? be combined with this construct anyhow?

Regards,
Markus
