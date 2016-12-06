From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 6 Dec 2016 11:15:23 +0100
Subject: [Cocci] Finding missing return value checks for some function
 calls with SmPL
In-Reply-To: <alpine.DEB.2.20.1612031900150.1978@hadrien>
References: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
 <alpine.DEB.2.20.1612031412090.2285@hadrien>
 <2453a7f0-492b-d945-8a2a-072822c49095@users.sourceforge.net>
 <alpine.DEB.2.20.1612031846280.1978@hadrien>
 <af9d55f5-3e00-e9bc-cfc9-5808641bb882@users.sourceforge.net>
 <alpine.DEB.2.20.1612031900150.1978@hadrien>
Message-ID: <b3c8d6ee-a0ab-2d43-4ae2-9376027f7a7b@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @find_?@
>> expression ex1, ex2, value;
>> identifier action =~ ?;
>> @@
>> *ex1 = action(...);
>>  ex2 = value;
>>
>>
>> I am unsure if such a source code search approach should eventually be split
>> into more SmPL processing steps.
> 
> (
> ex1 = action(...);
> ex2 = <+...ex1...+>;
> |
> *ex1 = action(...);
>  ex2 = value;
> )
> 
> is perhaps what you are looking for.

We discussed further possibilities around advanced usage of SmPL constraints a bit.
The software evolution is unclear in this direction and might be too limited
at the moment.

But the shown SmPL disjunction could also work with the Coccinelle software
for a while. It has got run time characteristics where I got a few concerns.

The asterisk functionality is used there so that source code places
can be marked as update candidates. Unfortunately, it seems that the software
development challenge can be too big for the specification of a generic
change approach.

Is such a small source code search pattern good enough in principle to be
integrated into the evolving script collection for checking of various source files
(including from Linux)?

Regards,
Markus
