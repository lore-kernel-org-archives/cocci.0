From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Oct 2016 11:00:30 +0200
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <alpine.DEB.2.10.1610141019550.3002@hadrien>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
Message-ID: <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> With which metavariables and corresponding programming interfaces can strings that
>> are passed to such functions be checked in more detail by the Coccinelle software?
> 
> The simplest would be to use python or ocaml code to make the checks that
> are needed.  You can use cocci.include_match(False) in python or
> Coccilib.include_match false in ocaml when your test detects that
> something is not suitable.

Thanks for your suggestion.


> coccinelle/demos/first.cocci may be helpful.

I have got the impression that this small SmPL script demonstrates the usage
of the mentioned function from your software library only for a simple position variable.
I do not see the way so far how desired data could be extracted from a function
(or expression?) parameter. Would you like to make the introspection options a bit
clearer for the SmPL interface?

Regards,
Markus
