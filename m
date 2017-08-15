From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Aug 2017 22:15:24 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708152208320.2049@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
Message-ID: <c961b90f-3155-6c3a-c27f-aba071d6598f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Now I am looking for a way to express the constraint that the statement list
>> metavariable should match only source code with two statements at least.
>> Can the search for duplicated source code be improved by the means of the
>> semantic patch language?
> 
> For two statements at least you could do:
> 
> (
> {
> s1
> s2
> ...
> }
> &
> {
> sl
> }
> )

Thanks for another example.


I admit that I am unused to such a variable combination with a SmPL conjunction.
Will this programming interface evolve any further?

Regards,
Markus
