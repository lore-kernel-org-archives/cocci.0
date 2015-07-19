From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Jul 2015 15:43:44 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.02.1507182154010.2086@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
 <alpine.DEB.2.02.1507182154010.2086@localhost6.localdomain6>
Message-ID: <55ABA990.30703@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I would like to achieve a bit of functionality which is already provided
>> by other popular static source code analysis tools
> 
> Why not use them then?

Such tools have got properties or limitations which I do not like.
I would like to reuse the strengths of the Coccinelle software a bit more.
I like its interfaces for the programming languages "OCaml" and "Python"
in principle.


>>   @show_unstored_return_values
>>    depends on !find_calls_for_initialisations
>>            && !find_calls_for_designated_initialisations
>>            && !find_calls_for_assignments@
> 
> I have the impression that you just want
> 
> f(...);

I would like to find a function call which has got specific properties
at such a source code place.
I can see the affected properties as an advanced software developer
almost immediately at the call site while I struggle with a mapping
to the semantic patch language in this use case.


> once you have determined that f has a return value.

I imagine to connect a function name list with this identifier in
a SmPL constraint again.


> No need for positions or dependencies on other rules.

I got the impression for a moment that it is eventually harder to match
something when a detail is absent compared to easily visible source code.
So I tried to use individual SmPL rules as dedicated filters.
Do I fiddle with them in a way which should be better covered
by SmPL disjunctions?

Is it strange anyhow that so many special cases would need to be excluded
so that a specific function call with an unchecked return value is finally
left over for further considerations?


> On the other hand, this is very liable to false positives when there
> is some good reason why the return value of the particular call
> to f doesn't matter.

I can agree to your view to some degree.

I see some opportunities for further fine-tuning of affected source code.
How often would it make sense to mark such special places with a cast
to void?

Regards,
Markus
