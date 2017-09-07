From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Sep 2017 15:51:03 +0200
Subject: [Cocci] Checking statement order for patch generation with SmPL
	support
In-Reply-To: <alpine.DEB.2.20.1709071519240.3168@hadrien>
References: <2a2b1ae2-ff84-2bda-3701-548dd9ee1edf@users.sourceforge.net>
 <alpine.DEB.2.20.1709071519240.3168@hadrien>
Message-ID: <c803beac-9fbe-f52d-18b5-6ef3ca3cbcb3@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Now I wonder why the software ?Coccinelle 1.0.6-00242-g3f038a5d? finds
>> this place relevant when the function call sequence does not fit to the order
>> I tried to express for a known use case.
>> I would appreciate further advice.
> 
> Because there is a loop,

This information is appropriate.

But I have got difficulties to interpret it in an useful way.


> and you did nothing to prevent an update to q because the free and the dereference.

I omitted an additional constraint for a simple test.


> @usage@
> identifier action, member, release=~"^.+free$";
> expression context,e;
> @@
> *release(context);
>  ... when != context = e
>      when any  // to get all results
> *action(..., (context)->member, ...)

Should the SmPL construct ?<+.. ...+>? work also similar to your suggestion?

Regards,
Markus
