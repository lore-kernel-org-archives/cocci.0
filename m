From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 14 Nov 2017 11:34:05 +0100
Subject: [Cocci] Coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
In-Reply-To: <alpine.DEB.2.20.1711141009250.2874@hadrien>
References: <alpine.DEB.2.20.1711140735020.2332@hadrien>
 <e1d8885a-4e3f-a980-00d8-76515d02da17@users.sourceforge.net>
 <alpine.DEB.2.20.1711141009250.2874@hadrien>
Message-ID: <533ab049-900c-fbb7-04e0-8dfaef492847@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> I didn't want to use a name with the pid, so that one could easily find
>>> this information while Coccinelle is running.
>>
>> Do you mark these data as ?hidden? in the file system?
> 
> I don't know what this means.

Do you fiddle with file attributes or use a dot as the first character
in the file name?


>> I imagine that the storage algorithm could become better configurable
>> besides the parameters ?--temp-files? and ?--tmp-dir?.
> 
> The problem is that running multiple coccinelles each with parallelism is
> fairly pointless,

The situation might be different if the execution environment provides
enough computation resources for processing with special data distributions.


> especially on the same semantic patch.

There can be restrictions usually.


> So the only people who do it will be those who don't understand
> how Coccinelle works.

This might be. - Or do they compare different software versions (in parallel)?


> Those people won't realize that they should use such extra options either.

Some time is needed to become more aware about advanced parameters.

Regards,
Markus
