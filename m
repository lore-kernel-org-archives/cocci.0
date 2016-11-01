From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 1 Nov 2016 21:43:17 +0100
Subject: [Cocci] [PATCH v2 1/3] Coccinelle: misc: Improve the matching
 of rules
In-Reply-To: <alpine.DEB.2.10.1611012134320.6300@hadrien>
References: <99f1a531ecff22247dfcbfc3c680d806f8e44822.1476635073.git.vaishali.thakkar@oracle.com>
 <36383906-21db-3c4f-3920-6eb9e462ad41@users.sourceforge.net>
 <alpine.DEB.2.10.1611012134320.6300@hadrien>
Message-ID: <c98f4533-1beb-d3f9-e5b1-6bac2d93b761@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> What do you mean by "a bit more fine-tuning"?  If you have a concrete
> suggestion, then make it.  But don't make work for other people to guess
> what you might mean.

I hoped that the SmPL source code below would explain my update suggestion
in a sufficient way to use two smaller SmPL disjunctions.


>> +(
>> + ret =
>> +(
>> +       request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
>> +|
>> +       devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
>> +)
>> + ;
>> +|
>> + return
>> +(
>> +        request_threaded_irq at p(irq, NULL, thread_fn, flags, ...)
>> +|
>> +        devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...)
>> +)
>> + ;
>> +)

Regards,
Markus
