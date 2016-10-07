From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 7 Oct 2016 08:23:20 +0200
Subject: [Cocci] scripts/coccicheck: Update for a comment?
In-Reply-To: <alpine.DEB.2.10.1610070803550.3074@hadrien>
References: <ea62a1ea-c566-65a0-e2fd-2ee96839cf48@users.sourceforge.net>
 <alpine.DEB.2.10.1610070749420.3074@hadrien>
 <76a6d8fa-03b9-5589-2885-fa62933dd391@users.sourceforge.net>
 <alpine.DEB.2.10.1610070803550.3074@hadrien>
Message-ID: <8d36952c-1dbb-bb26-ee57-3e1540c042c0@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccicheck?id=c802e87fbe2d4dd58982d01b3c39bc5a781223aa#n4
>>>
>>> How about submitting a patch to fix the problem?
>>
>> I would appreciate to become a bit more sure about the current storage location
>> which should be referenced in this file.
> 
> In the Documentation directory find . -name "*cocci*"
> 
> gives
> 
> ./dev-tools/coccinelle.rst
> 
> I think you could have done that yourself.

Does the usage of the format "reStructuredText" trigger further considerations
like the following?

* Does your feedback suggest that the path from this source file should be put
  in related places?

* Would it make sense to store such a file name in a special variable?

* When would you refer to generated file formats (like PDF) for this use case?

Regards,
Markus
