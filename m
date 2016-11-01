From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 1 Nov 2016 22:02:15 +0100
Subject: [Cocci] [PATCH v2 1/3] Coccinelle: misc: Improve the matching
 of rules
In-Reply-To: <alpine.DEB.2.10.1611012147510.6300@hadrien>
References: <99f1a531ecff22247dfcbfc3c680d806f8e44822.1476635073.git.vaishali.thakkar@oracle.com>
 <36383906-21db-3c4f-3920-6eb9e462ad41@users.sourceforge.net>
 <alpine.DEB.2.10.1611012134320.6300@hadrien>
 <c98f4533-1beb-d3f9-e5b1-6bac2d93b761@users.sourceforge.net>
 <alpine.DEB.2.10.1611012147510.6300@hadrien>
Message-ID: <37d8039b-23c9-c7de-10eb-eb0e77b84418@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Sorry, I thought it was the original code, and didn't realize that it was
> the suggestion..
> 
> But I don't think that the suggestion improves readability in any way.

I hoped that my SmPL script variant could influence the execution characteristics
in positive ways.


> Coccinelle disjunctions also float up to the statement level anyway,

I do not really understand this information at the moment.


> so the semantic patch that is actually applied to the code is the same in
> either case.

I assumed that the reduced code repetition could result in a desired effect.


>>>> +(
>>>> + ret =
>>>> +(
>>>> +       request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
>>>> +|
>>>> +       devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
>>>> +)
>>>> + ;
>>>> +|
>>>> + return
>>>> +(
>>>> +        request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
>>>> +|
>>>> +        devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
>>>> +)
>>>> + ;
>>>> +)

Regards,
Markus
