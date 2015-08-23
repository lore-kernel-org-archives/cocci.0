From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Aug 2015 22:20:31 +0200
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <alpine.DEB.2.10.1508231227480.2916@hadrien>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
 <55DA0DFD.8090005@users.sourceforge.net>
 <alpine.DEB.2.10.1508231227480.2916@hadrien>
Message-ID: <55DA2B0F.9080006@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There is no shared memory in ocaml.

Specific services (like databases) can provide some shared data storage.


> initialize and finalize naturally suggest that locations created in initialize
> can all be collected in a single execution of finalize. Since this is not possible,

I imagine that these SmPL rules could still be supported for their
original purpose.


> initialize and finalize are not allowed.

It might be easier for a moment to exclude these components under the
constraints of limited software development resources.
Such limitations will result in some software development challenges,
won't it?


> If you are OK with disjoint memory spaces per thread,
> just use the existing script for parallelism.

How do you think about the potential for extensions around task-specific
preparation and clean-up?


>> Does the parallelisation support need any more fine-tuning?
>> * How often is task preparation required before further data processing
>>   can be performed in parallel?
>>
>> * Which programming interfaces do you prefer for the storage
>>   of collected data in the fork-join work flow?
> No idea what either of these questions mean, but the whole point is that
> there is no join.

This technical restriction can lead to data processing difficulties,
can't it?

Are there any situations where SmPL scripts will need more control about
parallel work?

Regards,
Markus
