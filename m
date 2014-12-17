From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 17 Dec 2014 21:30:05 +0100
Subject: [Cocci] Distinguishing pointer data types with SmPL
In-Reply-To: <alpine.DEB.2.10.1412172019440.2523@hadrien>
References: <5478F848.1080808@users.sourceforge.net>
 <548371FB.9060402@users.sourceforge.net>
 <alpine.DEB.2.02.1412062219530.2256@localhost6.localdomain6>
 <54837413.8000902@users.sourceforge.net>
 <alpine.DEB.2.02.1412062232470.2256@localhost6.localdomain6>
 <5483806D.3070805@users.sourceforge.net>
 <alpine.DEB.2.02.1412062342540.2256@localhost6.localdomain6>
 <5483902E.8060109@users.sourceforge.net>
 <alpine.DEB.2.02.1412070749130.2044@localhost6.localdomain6>
 <54841AB2.6070609@users.sourceforge.net>
 <alpine.DEB.2.02.1412071027040.2044@localhost6.localdomain6>
 <54842A73.4000203@users.sourceforge.net>
 <alpine.DEB.2.02.1412071125130.2044@localhost6.localdomain6>
 <54842E04.9060800@users.sourceforge.net>
 <alpine.DEB.2.02.1412071244240.2044@localhost6.localdo! main6>
 <5484414F.4040900@users.sourceforge.net>
 <alpine.DEB.2.02.1412071337020.2030@localhost6.localdomain6>
 <54846702.1000505@users.sourceforge.net>
 <5491A1A0.40809@users.sourceforge.net>
 <alpine.DEB.2.10.1412172019440.2523@ha! drien>
Message-ID: <5491E7CD.3070207@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> * Which is the best way to distinguish non-pointer types from pointer data types
>>   with metavariables?
> 
> If you do the following:
> 
> @@
> expression * e1;
> expression e2;
> @@
> 
> (
> e1
> |
> e2
> )
> 
> Then e2 should match the non-pointer type expressions.

Is it relevant if you use "expression" or "type" here?


I guess that my previous use case was a bit different because the pointer
distinction was distributed over function parameters in separate SmPL rules.

I got the impression that a single metavariable with the SmPL type "type"
might be insufficient for a selection if the asterisk is omitted there.
Does the filter approach need to be disambiguated with additional criteria
like variable constraints or a part from the function implementation?

Regards,
Markus
