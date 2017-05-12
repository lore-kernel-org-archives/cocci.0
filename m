From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 May 2017 17:02:52 +0200
Subject: [Cocci] Easy search for elements besides binary operators with
 SmPL
In-Reply-To: <alpine.DEB.2.20.1705122248340.3416@hadrien>
References: <45237ab7-f7ba-07dd-e492-dc5ce330364e@users.sourceforge.net>
 <alpine.DEB.2.20.1705122137090.3416@hadrien>
 <e535373d-3307-2bb3-a843-5f7f413f6226@users.sourceforge.net>
 <alpine.DEB.2.20.1705122248340.3416@hadrien>
Message-ID: <877850e1-87cd-8495-15bd-5afa82ea4913@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> Maybe put parentheses around the second argument.  An isomorphism will
>>> drop them and you will avoid whatever parsing issue is being encountered.
>>
>> I do not observe a desired improvement after such a SmPL code adjustment.
> 
> Your change is not what I suggested either.  The second argument starts to
> the right of one comma and ends to the left of the next one.

I interpreted the ?second one? as belonging to the ellipsis in the binary
operator specification (for a moment).

Now I observe that the following SmPL script variants work as desired
in principle.

@find_last_option@
expression target;
identifier action;
@@
 target = action(...,
                 ( ...
*                | __GFP_NOFAIL
                 )
                );


@find_flag@
expression target;
identifier action;
@@
 target = action(...,
                 ( ...
*                | __GFP_NOFAIL
                 | ...
                 ),
                 ...);


I find it just strange that extra parentheses are needed in such an use case
at the moment.

Regards,
Markus
