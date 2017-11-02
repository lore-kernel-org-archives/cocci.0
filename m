From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 2 Nov 2017 16:00:48 +0100
Subject: [Cocci] Setting the section for a function with SmPL
In-Reply-To: <alpine.DEB.2.20.1711022226360.4551@hadrien>
References: <dae0fefb-6920-8e6a-76c6-b02b5fb0d4df@users.sourceforge.net>
 <alpine.DEB.2.20.1711022226360.4551@hadrien>
Message-ID: <41b71f07-b1da-55ea-5ae1-4fc14d1dfe0f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @section_specification@
>> type T;
>> @@
>>  T rcar_pcie_enable_msi(...)
>> + __attribute__((section ("my_update")))
> 
> I don't see any evidence that kernel developers would welcome this change
> in this form.

There is no welcome needed by them because the shown addition would be
nice for testing purposes.

I tried out if section specifications can be also supported by
the semantic patch language.
Does such functionality fit into the Coccinelle software?

Regards,
Markus
